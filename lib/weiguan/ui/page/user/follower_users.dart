import 'package:flutter/material.dart';

import '../../../entity/entity.dart';
import '../../../usecase/usecase.dart';
import '../../../util/util.dart';
import '../../../container.dart';
import '../../ui.dart';

class FollowerUsersPage extends StatelessWidget {
  final int userId;

  FollowerUsersPage({
    @required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('粉丝'),
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
  var _loaded = false;
  List<UserEntity> _followerUsers = [];

  @override
  void initState() {
    super.initState();

    _loadFollowerUsers();
  }

  void _loadFollowerUsers() async {
    if (_loaded) {
      return;
    }

    final cancelLoading = showLoading();
    try {
      final users = await WgContainer().userPresenter.followers(
          userId: widget.userId, limit: 20, offset: _followerUsers.length);

      setState(() {
        _loaded = users.length < 20;
        _followerUsers.addAll(users);
      });
    } on UseCaseException catch (e) {
      showMessage(e.message);
    } finally {
      cancelLoading();
    }
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (notification.metrics.extentAfter < 500) {
        _loadFollowerUsers();
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: _followerUsers.length,
        itemBuilder: (context, index) => UserTile(
          key: ValueKey(_followerUsers[index].id),
          user: _followerUsers[index],
          onFollow: () => setState(() {
            _followerUsers[index] =
                _followerUsers[index].copyWith(isFollowing: true);
          }),
          onUnfollow: () => setState(() {
            _followerUsers[index] =
                _followerUsers[index].copyWith(isFollowing: false);
          }),
        ),
      ),
    );
  }
}
