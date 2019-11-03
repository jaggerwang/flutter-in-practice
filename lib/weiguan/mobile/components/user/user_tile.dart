import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../utils/utils.dart';
import '../../../entities/entities.dart';
import '../../../services/services.dart';
import '../../pages/pages.dart';

class UserTile extends StatelessWidget {
  final UserEntity user;
  final void Function() onFollow;
  final void Function() onUnfollow;

  UserTile({
    Key key,
    @required this.user,
    this.onFollow,
    this.onUnfollow,
  }) : super(key: key);

  void _followUser(BuildContext context) {
    StoreProvider.of<AppState>(context).dispatch(userFollowAction(
      followingId: user.id,
      onSuccess: () {
        if (onFollow != null) onFollow();
      },
      onFailure: (notice) => showSnackBar(context, notice),
    ));
  }

  void _unfollowUser(BuildContext context) {
    StoreProvider.of<AppState>(context).dispatch(userUnfollowAction(
      followingId: user.id,
      onSuccess: () {
        if (onUnfollow != null) onUnfollow();
      },
      onFailure: (notice) => showSnackBar(context, notice),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => UserDetailPage(userId: user.id),
      )),
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: user.avatar == null
            ? null
            : CachedNetworkImageProvider(
                user.avatar.thumbs[FileThumbType.small]),
        child: user.avatar == null ? Icon(Icons.person) : null,
      ),
      title: Text(user.username),
      subtitle: Text(user.intro),
      trailing: user.isFollowing
          ? FlatButton(
              onPressed: () => _unfollowUser(context),
              textColor: Theme.of(context).primaryColor,
              child: Text('取消关注'),
            )
          : FlatButton(
              onPressed: () => _followUser(context),
              textColor: Theme.of(context).primaryColor,
              child: Text('关注'),
            ),
    );
  }
}
