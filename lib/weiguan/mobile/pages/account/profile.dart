import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/utils.dart';
import '../../../container.dart';
import '../../../entities/entities.dart';
import '../../../services/services.dart';
import '../pages.dart';

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
  Store<AppState> _store;
  var _loading = false;

  void _loadAccountInfo() {
    setState(() {
      _loading = true;
    });
    _store.dispatch(accountInfoAction(
      onSuccess: (user) {
        setState(() {
          _loading = false;
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

  void _modifyAccount(AccountProfileForm form, BuildContext context) {
    _store.dispatch(accountModifyAction(
      form: form,
      onSuccess: (user) {
        Navigator.of(context).pop();
        showSnackBar(this.context,
            NoticeEntity(message: '设置成功', level: NoticeLevel.success));
      },
      onFailure: (notice) => showSnackBar(context, notice),
    ));
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
      setState(() {
        _loading = true;
      });
      _store.dispatch(storageUploadAction(
        form: StorageUploadForm(
          path: 'avatar',
          files: [file.path],
        ),
        onSuccess: (files) {
          _store.dispatch(accountModifyAction(
            form: AccountProfileForm(avatarId: files.first.id),
            onSuccess: (user) {
              setState(() {
                _loading = false;
              });
              showSnackBar(context,
                  NoticeEntity(message: '设置成功', level: NoticeLevel.success));
            },
            onFailure: (notice) {
              setState(() {
                _loading = false;
              });
              showSnackBar(context, notice);
            },
          ));
        },
        onFailure: (notice) {
          setState(() {
            _loading = false;
          });
          showSnackBar(context, notice);
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserEntity>(
      onInit: (store) {
        _store = store;
      },
      converter: (store) => store.state.account.user,
      distinct: true,
      onInitialBuild: (vm) {
        _loadAccountInfo();
      },
      builder: (context, vm) => Stack(
        children: [
          Column(
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
