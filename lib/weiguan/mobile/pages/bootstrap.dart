import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../utils/utils.dart';
import '../../entities/entities.dart';
import '../../services/services.dart';

class BootstrapPage extends StatelessWidget {
  final bool needLogout;

  BootstrapPage({this.needLogout = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _Body(needLogout: needLogout),
    );
  }
}

class _Body extends StatefulWidget {
  final bool needLogout;

  _Body({this.needLogout = false});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  Store<AppState> _store;
  var _failed = false;

  void _bootstrap() {
    final completer = Completer<UserEntity>();
    if (widget.needLogout) {
      _store.dispatch(accountLogoutAction(
        onSuccess: (user) => completer.complete(user),
        onFailure: (notice) => completer.completeError(notice),
      ));
    } else {
      completer.complete();
    }

    completer.future.then((user) {
      _store.dispatch(accountInfoAction(
        onSuccess: (user) {
          Navigator.of(context)
              .pushReplacementNamed(user == null ? '/login' : '/tab');
        },
        onFailure: (notice) {
          setState(() {
            _failed = true;
          });
          showSnackBar(context, notice);
        },
      ));
    }).catchError((notice) => showSnackBar(context, notice));
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Null>(
      onInit: (store) {
        _store = store;
      },
      converter: (store) => null,
      distinct: true,
      onInitialBuild: (vm) {
        _bootstrap();
      },
      builder: (context, vm) => Center(
        child: Column(
          children: [
            Spacer(flex: 5),
            FractionallySizedBox(
              widthFactor: 0.5,
              child: Image(
                image: AssetImage('assets/weiguan/weiguan.png'),
              ),
            ),
            Spacer(),
            _failed
                ? Column(
                    children: [
                      Text(
                        '网络请求出错',
                        style: Theme.of(context)
                            .textTheme
                            .body1
                            .copyWith(color: Theme.of(context).hintColor),
                      ),
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            _failed = false;
                          });
                          _bootstrap();
                        },
                        child: Text(
                          '再试一次',
                          style: Theme.of(context)
                              .textTheme
                              .body1
                              .copyWith(color: Theme.of(context).hintColor),
                        ),
                      ),
                    ],
                  )
                : Text(
                    '网络请求中...',
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(color: Theme.of(context).hintColor),
                  ),
            Spacer(flex: 5),
          ],
        ),
      ),
    );
  }
}
