import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';

import '../../../entity/entity.dart';
import '../../../usecase/usecase.dart';
import '../../../util/util.dart';
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

    _loadAccountInfo();
  }

  void _loadAccountInfo() async {
    final cancelLoading = showLoading();
    try {
      await WgContainer().accountPresenter.info();
    } on UseCaseException catch (e) {
      showMessage(e.message);
    } finally {
      cancelLoading();
    }
  }

  void _modifyAccount(AccountProfileForm form, BuildContext context) async {
    final cancelLoading = showLoading();
    try {
      await WgContainer().accountPresenter.modify(form);

      showMessage('设置成功', level: MessageLevel.success);
      Navigator.of(context).pop();
    } on UseCaseException catch (e) {
      showMessage(e.message);
    } finally {
      cancelLoading();
    }
  }

  void _selectAvatar() async {
    final source = await showModalBottomSheet<ImageSource>(
        context: context,
        builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FlatButton(
                  onPressed: () =>
                      Navigator.of(context).pop(ImageSource.gallery),
                  textColor: Theme.of(context).primaryColor,
                  child: Text('从相册选取'),
                ),
                Divider(),
                FlatButton(
                  onPressed: () =>
                      Navigator.of(context).pop(ImageSource.camera),
                  textColor: Theme.of(context).primaryColor,
                  child: Text('用相机拍摄'),
                ),
                Divider(),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('取消'),
                ),
              ],
            ));
    if (source == null) {
      return;
    }

    final file = await ImagePicker.pickImage(source: source);
    if (file != null) {
      final cancelLoading = showLoading();
      try {
        await WgContainer().accountPresenter.modifyAvatar(file.path);

        showMessage('设置成功', level: MessageLevel.success);
      } on UseCaseException catch (e) {
        showMessage(e.message);
      } finally {
        cancelLoading();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserEntity>(
      converter: (store) => store.state.account.user,
      distinct: true,
      builder: (context, vm) => Column(
        children: [
          Card(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: WgContainer().theme.marginSizeLarge),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: vm.avatar == null
                            ? null
                            : CachedNetworkImageProvider(
                                vm.avatar.thumbs[FileThumbType.small]),
                        child: vm.avatar == null
                            ? Icon(Icons.account_circle)
                            : null,
                      ),
                      RaisedButton(
                        onPressed: _selectAvatar,
                        child: Text('设置头像'),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () => Navigator.of(context).push(
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
                        onSubmit: (value, context) => _modifyAccount(
                            AccountProfileForm(username: value), context),
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
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ModifyMobilePage(
                        onSubmit: (mobile, code, context) => _modifyAccount(
                          AccountProfileForm(mobile: mobile, code: code),
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
