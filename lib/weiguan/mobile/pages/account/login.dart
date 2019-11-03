import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../container.dart';
import '../../../utils/utils.dart';
import '../../../services/services.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
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
  static final _formKey = GlobalKey<FormState>();

  FocusNode _passwordFocusNode;
  var _loading = false;
  var _form = AccountLoginForm();

  @override
  void initState() {
    super.initState();

    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();

    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      setState(() {
        _loading = true;
      });
      StoreProvider.of<AppState>(context).dispatch(accountLoginAction(
        form: _form,
        onSuccess: (user) {
          setState(() {
            _loading = false;
          });
          Navigator.of(context).pushReplacementNamed('/tab');
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
    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(WgContainer().theme.paddingSizeSmall),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          onSaved: (value) => _form.username = value,
                          onFieldSubmitted: (value) => FocusScope.of(context)
                              .requestFocus(_passwordFocusNode),
                          decoration: InputDecoration(
                            icon: Icon(Icons.account_circle),
                            hintText: '用户名',
                          ),
                        ),
                        TextFormField(
                          focusNode: _passwordFocusNode,
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          onSaved: (value) => _form.password = value,
                          onFieldSubmitted: (value) => _submit(),
                          decoration: InputDecoration(
                            icon: Icon(Icons.vpn_key),
                            hintText: '密码',
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: WgContainer().theme.marginSizeNormal),
                          child: RaisedButton(
                            padding: EdgeInsets.all(
                                WgContainer().theme.paddingSizeNormal),
                            onPressed: _submit,
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              '登录',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .button
                                  .copyWith(
                                    fontSize: 16,
                                    letterSpacing: 32,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '还没有帐号？',
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(color: Theme.of(context).hintColor),
                  ),
                  FlatButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/register'),
                    child: Text(
                      '注册一个',
                      style: Theme.of(context)
                          .textTheme
                          .body1
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Visibility(
          visible: _loading,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}
