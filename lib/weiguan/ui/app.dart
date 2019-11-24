import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:package_info/package_info.dart';
import 'package:redux/redux.dart';
import 'package:bot_toast/bot_toast.dart';

import '../container.dart';
import 'ui.dart';

class WgApp extends StatelessWidget {
  final Store<AppState> store;
  final PackageInfo packageInfo;
  final ThemeData theme;

  WgApp({
    @required this.store,
    @required this.packageInfo,
    @required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: BotToastInit(
        child: MaterialApp(
          title: packageInfo.appName,
          theme: theme,
          navigatorKey: WgContainer().rootNavigatorKey,
          navigatorObservers: [BotToastNavigatorObserver()],
          routes: {
            '/': (context) => BootstrapPage(),
            '/register': (context) => RegisterPage(),
            '/login': (context) => LoginPage(),
            '/tab': (context) => TabPage(),
          },
        ),
      ),
    );
  }
}
