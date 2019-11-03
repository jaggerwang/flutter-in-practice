import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../utils/utils.dart';
import '../../../entities/entities.dart';
import '../../../services/services.dart';
import '../../components/components.dart';

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
  List<UserEntity> _followingUsers = [];

  void _loadFollowingUsers() {
    if (_loaded) {
      return;
    }

    setState(() {
      _loading = true;
    });
    _store.dispatch(userFollowingsAction(
      userId: widget.userId,
      limit: 20,
      offset: _followingUsers.length,
      onSuccess: (users) {
        setState(() {
          _loading = false;
          _loaded = users.length < 20;
          _followingUsers.addAll(users);
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
        _loadFollowingUsers();
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
        _loadFollowingUsers();
      },
      builder: (context, vm) => Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: _handleScrollNotification,
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: _followingUsers.length,
              itemBuilder: (context, index) => UserTile(
                key: ValueKey(_followingUsers[index].id),
                user: _followingUsers[index],
                onFollow: () => setState(() {
                  _followingUsers[index] =
                      _followingUsers[index].copyWith(isFollowing: true);
                }),
                onUnfollow: () => setState(() {
                  _followingUsers[index] =
                      _followingUsers[index].copyWith(isFollowing: false);
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
