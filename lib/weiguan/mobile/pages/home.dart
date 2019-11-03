import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../utils/utils.dart';
import '../../entities/entities.dart';
import '../../services/services.dart';
import '../components/components.dart';

class HomePage extends StatelessWidget {
  static final _bodyKey = GlobalKey<_BodyState>();

  static void refresh() {
    _bodyKey.currentState._refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: _Body(key: _bodyKey),
      bottomNavigationBar: WgTabBar(currentIndex: 0),
    );
  }
}

class _Body extends StatefulWidget {
  _Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  Store<AppState> _store;
  List<PostEntity> _vm;
  var _loading = false;
  var _loaded = false;
  Completer _completer;

  void _loadFollowingPosts({
    bool refresh = false,
  }) {
    if (!refresh && _loaded) {
      return;
    }

    setState(() {
      _loading = true;
    });
    _store.dispatch(postFollowingAction(
      limit: 10,
      afterId: refresh && _vm.isNotEmpty ? _vm.first.id : null,
      beforeId: !refresh && _vm.isNotEmpty ? _vm.last.id : null,
      onSuccess: (posts) {
        setState(() {
          _loading = false;
          if (!refresh) {
            _loaded = posts.length < 10;
          }
          if (_completer != null) {
            _completer.complete();
            _completer = null;
          }
        });
      },
      onFailure: (notice) {
        setState(() {
          _loading = false;
          if (_completer != null) {
            _completer.complete();
            _completer = null;
          }
        });
        showSnackBar(context, notice);
      },
    ));
  }

  Future _refresh({showIndicator: false}) {
    if (showIndicator) _completer = Completer();
    _loadFollowingPosts(refresh: true);
    return showIndicator ? _completer.future : Future.value();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (notification.metrics.extentAfter < 500) {
        _loadFollowingPosts();
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<PostEntity>>(
      onInit: (store) {
        _store = store;
      },
      converter: (store) {
        _vm = store.state.post.followingPosts;
        return _vm;
      },
      distinct: true,
      onInitialBuild: (vm) {
        _refresh();
      },
      builder: (context, vm) => Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: _handleScrollNotification,
            child: RefreshIndicator(
              onRefresh: () => _refresh(showIndicator: true),
              child: ListView.builder(
                itemCount: vm.length,
                itemBuilder: (context, index) => PostTile(
                  key: ValueKey(vm[index].id),
                  post: vm[index],
                ),
              ),
            ),
          ),
          Visibility(
            visible: _loading && (_completer?.isCompleted ?? true),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
