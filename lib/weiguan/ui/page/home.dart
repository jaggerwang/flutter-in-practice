import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../entity/entity.dart';
import '../../usecase/usecase.dart';
import '../../util/util.dart';
import '../../container.dart';
import '../ui.dart';

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
  List<PostEntity> _vm = [];
  var _loaded = false;

  @override
  void initState() {
    super.initState();

    _loadFollowingPosts();
  }

  Future<void> _loadFollowingPosts({
    bool refresh = false,
  }) async {
    if (!refresh && _loaded) {
      return;
    }

    final cancelLoading = showLoading();
    try {
      final posts = await WgContainer().postPresenter.following(
          limit: 10,
          afterId: refresh && _vm.isNotEmpty ? _vm.first.id : null,
          beforeId: !refresh && _vm.isNotEmpty ? _vm.last.id : null);

      setState(() {
        if (!refresh) {
          _loaded = posts.length < 10;
        }
      });
    } on UseCaseException catch (e) {
      showMessage(e.message);
    } finally {
      cancelLoading();
    }
  }

  Future<void> _refresh() async {
    await _loadFollowingPosts(refresh: true);
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
      converter: (store) {
        _vm = store.state.post.followingPosts;
        return _vm;
      },
      distinct: true,
      builder: (context, vm) => NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.builder(
            itemCount: vm.length,
            itemBuilder: (context, index) => PostTile(
              key: ValueKey(vm[index].id),
              post: vm[index],
            ),
          ),
        ),
      ),
    );
  }
}
