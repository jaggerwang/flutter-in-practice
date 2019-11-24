import 'package:flutter/material.dart';

import '../../../entity/entity.dart';
import '../../../container.dart';
import '../../ui.dart';

class FollowingUsersPage extends StatelessWidget {
  final int userId;

  FollowingUsersPage({
    @required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关注'),
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
  List<UserEntity> _followingUsers = [];

  @override
  void initState() {
    super.initState();

    _loadFollowingUsers();
  }

  void _loadFollowingUsers() async {
    if (_loaded) {
      return;
    }

    WgContainer().basePresenter.doWithLoading(() async {
      final users = await WgContainer().userPresenter.following(
          userId: widget.userId, limit: 20, offset: _followingUsers.length);

      setState(() {
        _loaded = users.length < 20;
        _followingUsers.addAll(users);
      });
    });
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (notification.metrics.extentAfter < 500) {
        _loadFollowingUsers();
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
        itemCount: _followingUsers.length,
        itemBuilder: (context, index) => UserTile(
          key: ValueKey(_followingUsers[index].id),
          user: _followingUsers[index],
          onFollow: () => setState(() {
            _followingUsers[index] =
                _followingUsers[index].copyWith(following: true);
          }),
          onUnfollow: () => setState(() {
            _followingUsers[index] =
                _followingUsers[index].copyWith(following: false);
          }),
        ),
      ),
    );
  }
}
