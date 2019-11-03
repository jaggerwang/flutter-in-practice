import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../entity/entity.dart';
import '../../../usecase/usecase.dart';
import '../../../util/util.dart';
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
    final cancelLoading = showLoading();
    try {
      await WgContainer().userPresenter.follow(user.id);

      if (onFollow != null) onFollow();
    } on UseCaseException catch (e) {
      showMessage(e.message);
    } finally {
      cancelLoading();
    }
  }

  void _unfollowUser(BuildContext context) async {
    final cancelLoading = showLoading();
    try {
      await WgContainer().userPresenter.unfollow(user.id);

      if (onUnfollow != null) onUnfollow();
    } on UseCaseException catch (e) {
      showMessage(e.message);
    } finally {
      cancelLoading();
    }
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
