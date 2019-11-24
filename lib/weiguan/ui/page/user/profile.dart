import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';

import '../../../entity/entity.dart';
import '../../../container.dart';
import '../../ui.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人资料'),
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
  void initState() {
    super.initState();

    _loadLoggedUser();
  }

  void _loadLoggedUser() async {
    WgContainer().basePresenter.doWithLoading(() async {
      await WgContainer().userPresenter.logged();
    });
  }

  void _modifyUser(UserProfileForm form, BuildContext context) async {
    WgContainer().basePresenter.doWithLoading(() async {
      await WgContainer().userPresenter.modify(form);

      WgContainer()
          .basePresenter
          .showMessage('设置成功', level: MessageLevel.SUCCESS);
      WgContainer().basePresenter.navigator(context).pop();
    });
  }

  void _selectAvatar() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SelectImageSource(),
    );
    if (source == null) {
      return;
    }

    final file = await ImagePicker.pickImage(source: source);
    if (file != null) {
      WgContainer().basePresenter.doWithLoading(() async {
        await WgContainer().userPresenter.modifyAvatar(file.path);

        WgContainer()
            .basePresenter
            .showMessage('设置成功', level: MessageLevel.SUCCESS);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserEntity>(
      converter: (store) => store.state.user.logged,
      distinct: true,
      builder: (context, vm) => Column(
        children: [
          Card(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: WgContainer().theme.marginSizeLarge),
                  child: GestureDetector(
                    onTap: Feedback.wrapForTap(
                      _selectAvatar,
                      context,
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: vm.avatar == null
                          ? null
                          : CachedNetworkImageProvider(
                              vm.avatar.thumbs[FileThumbType.SMALL]),
                      child:
                          vm.avatar == null ? Icon(Icons.account_circle) : null,
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () => WgContainer().basePresenter.navigator().push(
                        MaterialPageRoute(
                          builder: (context) => TextInputPage(
                            title: '设置用户名',
                            hintText: '2-20 个中英文字符',
                            initialValue: vm.username,
                            validator: (value) {
                              if (value.length < 2 || value.length > 20) {
                                return '长度不符合要求';
                              }
                              return null;
                            },
                            onSubmit: (value, context) => _modifyUser(
                                UserProfileForm(username: value), context),
                          ),
                        ),
                      ),
                  title: Text('用户名'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(vm.username),
                      Icon(Icons.keyboard_arrow_right),
                    ],
                  ),
                ),
                Divider(height: 1),
                ListTile(
                  onTap: () => WgContainer().basePresenter.navigator().push(
                        MaterialPageRoute(
                          builder: (context) => ModifyMobilePage(
                            onSubmit: (mobile, code, context) => _modifyUser(
                              UserProfileForm(mobile: mobile, code: code),
                              context,
                            ),
                          ),
                        ),
                      ),
                  title: Text('手机'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(vm.mobile ?? '未填写'),
                      Icon(Icons.keyboard_arrow_right),
                    ],
                  ),
                ),
                Divider(height: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
