import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../utils/utils.dart';
import '../../../entities/entities.dart';
import '../../../services/services.dart';
import '../../components/components.dart';

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
  Store<AppState> _store;
  var _loading = false;
  var _loaded = false;
  List<UserEntity> _followerUsers = [];

  void _loadFollowerUsers() {
    if (_loaded) {
      return;
    }

    setState(() {
      _loading = true;
    });
    _store.dispatch(userFollowersAction(
      userId: widget.userId,
      limit: 20,
      offset: _followerUsers.length,
      onSuccess: (users) {
        setState(() {
          _loading = false;
          _loaded = users.length < 20;
          _followerUsers.addAll(users);
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
        _loadFollowerUsers();
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
        _loadFollowerUsers();
      },
      builder: (context, vm) => Stack(
        children: [
          NotificationListener<ScrollNotification>(
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
