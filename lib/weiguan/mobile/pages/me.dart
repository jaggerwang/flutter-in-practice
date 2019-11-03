import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../container.dart';
import '../../entities/entities.dart';
import '../../services/services.dart';
import '../components/components.dart';
import 'pages.dart';

class MePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
      ),
      body: _Body(),
      bottomNavigationBar: WgTabBar(currentIndex: 2),
    );
  }
}

class _Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserEntity>(
      converter: (store) => store.state.account.user,
      distinct: true,
      builder: (context, vm) {
        return ListView(
          children: [
            Card(
              child: ListTile(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                )),
                leading: GestureDetector(
                  onTap: Feedback.wrapForTap(
                    () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserDetailPage(userId: vm.id),
                    )),
                    context,
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: vm.avatar == null
                        ? null
                        : CachedNetworkImageProvider(
                            vm.avatar.thumbs[FileThumbType.small]),
                    child:
                        vm.avatar == null ? Icon(Icons.account_circle) : null,
                  ),
                ),
                title: Text(vm.username),
                subtitle: Text('${vm.mobile ?? '尚未填写手机'}'),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
            Card(
              child: Column(
                children: [
                  ListTile(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LikedPostsPage(userId: vm.id),
                    )),
                    title: Text('喜欢'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  Divider(height: 1),
                  ListTile(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FollowingUsersPage(userId: vm.id),
                    )),
                    title: Text('关注'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  Divider(height: 1),
                  ListTile(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FollowerUsersPage(userId: vm.id),
                    )),
                    title: Text('粉丝'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: WgContainer().theme.marginSizeSmall,
                vertical: WgContainer().theme.marginSizeLarge,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      padding:
                          EdgeInsets.all(WgContainer().theme.paddingSizeNormal),
                      onPressed: () =>
                          Navigator.of(context, rootNavigator: true)
                              .pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BootstrapPage(needLogout: true),
                                  ),
                                  (route) => false),
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        '退出',
                        style:
                            Theme.of(context).primaryTextTheme.button.copyWith(
                                  fontSize: 16,
                                  letterSpacing: 32,
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: WgContainer().theme.marginSizeSmall,
              ),
              alignment: Alignment.center,
              child: Text(
                '${WgContainer().config.packageInfo.appName} v${WgContainer().config.packageInfo.version}@blog.jaggerwang.net',
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(color: Theme.of(context).hintColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
