import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../container.dart';
import '../../../utils/utils.dart';
import '../../../services/services.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册'),
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
  var _form = AccountRegisterForm();

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
      StoreProvider.of<AppState>(context).dispatch(accountRegisterAction(
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
                            labelText: '用户名',
                            hintText: '2-20 个中英文字符',
                          ),
                          validator: (value) {
                            if (value.length < 2 || value.length > 20) {
                              return '长度不符合要求';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          focusNode: _passwordFocusNode,
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          onSaved: (value) => _form.password = value,
                          onFieldSubmitted: (value) => _submit(),
                          decoration: InputDecoration(
                            labelText: '密码',
                            hintText: '6-20 个字符',
                          ),
                          validator: (value) {
                            if (value.length < 6 || value.length > 20) {
                              return '长度不符合要求';
                            }
                            return null;
                          },
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
                              '注册',
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
              )
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
