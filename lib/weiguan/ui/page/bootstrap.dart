import 'package:flutter/material.dart';

import '../../usecase/usecase.dart';
import '../../util/util.dart';
import '../../container.dart';

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
  @override
  void initState() {
    super.initState();

    _bootstrap();
  }

  void _bootstrap() async {
    final cancelLoading = showLoading();
    try {
      if (widget.needLogout) {
        await Future.delayed(Duration(seconds: 1), () async {
          await WgContainer().accountPresenter.logout();
        });
      }

      final user = await WgContainer().accountPresenter.info();

      Navigator.of(context)
          .pushReplacementNamed(user == null ? '/login' : '/tab');
    } on UseCaseException catch (e) {
      showMessage('网络请求出错（${e.message}），请重启应用。');
    } finally {
      cancelLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
          Text(
            '网络请求中...',
            style: Theme.of(context)
                .textTheme
                .body1
                .copyWith(color: Theme.of(context).hintColor),
          ),
          Spacer(flex: 5),
        ],
      ),
    );
  }
}
