import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../entity/entity.dart';
import '../../../container.dart';
import '../../ui.dart';

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

  void _followUser(BuildContext context) async {
    WgContainer().basePresenter.doWithLoading(() async {
      await WgContainer().userPresenter.follow(user.id);

      if (onFollow != null) onFollow();
    });
  }

  void _unfollowUser(BuildContext context) async {
    WgContainer().basePresenter.doWithLoading(() async {
      await WgContainer().userPresenter.unfollow(user.id);

      if (onUnfollow != null) onUnfollow();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () =>
          WgContainer().basePresenter.navigator().push(MaterialPageRoute(
                builder: (context) => UserDetailPage(userId: user.id),
              )),
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: user.avatar == null
            ? null
            : CachedNetworkImageProvider(
                user.avatar.thumbs[FileThumbType.SMALL]),
        child: user.avatar == null ? Icon(Icons.person) : null,
      ),
      title: Text(user.username),
      subtitle: Text(user.intro),
      trailing: user.following
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
