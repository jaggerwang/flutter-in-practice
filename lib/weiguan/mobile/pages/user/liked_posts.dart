import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../utils/utils.dart';
import '../../../entities/entities.dart';
import '../../../services/services.dart';
import '../../components/components.dart';

class LikedPostsPage extends StatelessWidget {
  final int userId;

  LikedPostsPage({
    @required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('喜欢'),
      ),
      body: _Body(
        userId: userId,
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final int userId;

  _Body({
    @required this.userId,
  });

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  Store<AppState> _store;
  var _loading = false;
  var _loaded = false;
  List<PostEntity> _likedPosts = [];

  void _loadLikedPosts() {
    if (_loaded) {
      return;
    }

    setState(() {
      _loading = true;
    });
    _store.dispatch(postLikedAction(
      userId: widget.userId,
      limit: 10,
      offset: _likedPosts.length,
      onSuccess: (posts) {
        setState(() {
          _loading = false;
          _loaded = posts.length < 10;
          _likedPosts.addAll(posts);
        });
      },
      onFailure: (notice) {
        setState(() {
          _loading = false;
        });
        showSnackBar(context, notice);
      },
    ));
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (notification.metrics.extentAfter < 500) {
        _loadLikedPosts();
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Null>(
      onInit: (store) {
        _store = store;
      },
      converter: (store) => null,
      distinct: true,
      onInitialBuild: (vm) {
        _loadLikedPosts();
      },
      builder: (context, vm) => Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: _handleScrollNotification,
            child: ListView.builder(
              itemCount: _likedPosts.length,
              itemBuilder: (context, index) => PostTile(
                key: ValueKey(_likedPosts[index].id),
                post: _likedPosts[index],
                onLike: () => setState(() {
                  _likedPosts[index] =
                      _likedPosts[index].copyWith(isLiked: true);
                }),
                onUnlike: () => setState(() {
                  _likedPosts[index] =
                      _likedPosts[index].copyWith(isLiked: false);
                }),
                onDelete: () => setState(() {
                  _likedPosts.removeAt(index);
                }),
              ),
            ),
          ),
          Visibility(
            visible: _loading,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
