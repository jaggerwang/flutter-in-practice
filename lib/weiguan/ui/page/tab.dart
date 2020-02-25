import 'dart:async';

import 'package:flutter/material.dart';

import '../ui.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  final _navigatorKeys =
      WgTabBar.tabs.map((v) => GlobalKey<NavigatorState>()).toList();
  var _tab = 0;

  bool _handleSwitchTabNotification(SwitchTabNotification notification) {
    setState(() {
      _tab = notification.tab;
    });
    return true;
  }

  Future<bool> _onWillPop() async {
    final maybePop = await _navigatorKeys[_tab].currentState.maybePop();
    return Future.value(!maybePop);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: NotificationListener<SwitchTabNotification>(
        onNotification: _handleSwitchTabNotification,
        child: IndexedStack(
          index: _tab,
          children: WgTabBar.tabs
              .asMap()
              .entries
              .map(
                (entry) => Navigator(
                  key: _navigatorKeys[entry.key],
                  onGenerateRoute: (settings) {
                    WidgetBuilder builder;
                    switch (settings.name) {
                      case '/':
                        builder = entry.value['builder'];
                        break;
                      default:
                        throw Exception('Unknown route: ${settings.name}');
                    }
                    return MaterialPageRoute(
                      builder: builder,
                      settings: settings,
                    );
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
