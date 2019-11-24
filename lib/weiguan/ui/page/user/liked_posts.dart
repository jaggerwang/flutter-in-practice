import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../entity/entity.dart';
import '../../../container.dart';
import '../../ui.dart';

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
      bottomNavigationBar: WgTabBar(currentIndex: 2),
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
  var _loaded = false;
  List<PostEntity> _likedPosts = [];

  @override
  void initState() {
    super.initState();

    _loadLikedPosts();
  }

  void _loadLikedPosts() async {
    if (_loaded) {
      return;
    }

    WgContainer().basePresenter.doWithLoading(() async {
      final posts = await WgContainer()
          .postPresenter
          .liked(userId: widget.userId, limit: 10, offset: _likedPosts.length);

      setState(() {
        _loaded = posts.length < 10;
        _likedPosts.addAll(posts);
      });
    });
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
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: ListView.builder(
        itemCount: _likedPosts.length,
        itemBuilder: (context, index) => PostTile(
          key: ValueKey(_likedPosts[index].id),
          post: _likedPosts[index],
          onLike: () => setState(() {
            _likedPosts[index] = _likedPosts[index].copyWith(liked: true);
          }),
          onUnlike: () => setState(() {
            _likedPosts[index] = _likedPosts[index].copyWith(liked: false);
          }),
          onDelete: () => setState(() {
            _likedPosts.removeAt(index);
          }),
        ),
      ),
    );
  }
}
