import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../usecase/usecase.dart';
import '../../../util/util.dart';
import '../../../container.dart';
import '../../ui.dart';

class ModifyMobilePage extends StatelessWidget {
  static final _bodyKey = GlobalKey<_BodyState>();

  final void Function(String mobile, String code, BuildContext context)
      onSubmit;

  ModifyMobilePage({@required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置手机'),
        actions: [
          FlatButton(
            onPressed: () => _bodyKey.currentState._submit(),
            child: Text(
              '完成',
              style: Theme.of(context).primaryTextTheme.subhead,
            ),
          ),
        ],
      ),
      body: _Body(key: _bodyKey, onSubmit: onSubmit),
    );
  }
}

class _Body extends StatefulWidget {
  final void Function(String mobile, String code, BuildContext context)
      onSubmit;

  _Body({Key key, @required this.onSubmit}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  static final _formKey = GlobalKey<FormState>();

  FocusNode _codeFocusNode;
  String _mobile = '';
  String _code = '';

  @override
  void initState() {
    super.initState();

    _codeFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _codeFocusNode.dispose();

    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      widget.onSubmit(_mobile, _code, context);
    }
  }

  void _sendVerifyCode() async {
    _formKey.currentState.save();

    final cancelLoading = showLoading();
    try {
      final code = await WgContainer()
          .accountPresenter
          .sendMobileVerifyCode('modify', _mobile);

      showMessage('验证码 $code 发送成功', level: MessageLevel.success);
    } on UseCaseException catch (e) {
      showMessage(e.message);
    } finally {
      cancelLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Null>(
      onInit: (store) {
        _mobile = store.state.account.user.mobile;
      },
      converter: (store) => null,
      distinct: true,
      builder: (context, vm) => Container(
          padding: EdgeInsets.all(WgContainer().theme.paddingSizeNormal),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: true,
                        initialValue: _mobile,
                        onSaved: (value) => _mobile = value,
                        onFieldSubmitted: (value) =>
                            FocusScope.of(context).requestFocus(_codeFocusNode),
                        validator: (value) {
                          if (value.length != 11) {
                            return '长度不符合要求';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: '手机号，11 位数字',
                          suffixIcon: IconButton(
                            onPressed: _sendVerifyCode,
                            icon: Icon(Icons.send),
                          ),
                        ),
                      ),
                      TextFormField(
                        focusNode: _codeFocusNode,
                        onSaved: (value) => _code = value,
                        onFieldSubmitted: (value) => _submit(),
                        validator: (value) {
                          if (value.length != 6) {
                            return '长度不符合要求';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: '验证码，6 位数字',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
