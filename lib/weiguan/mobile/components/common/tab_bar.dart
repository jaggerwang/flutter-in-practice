import 'package:flutter/material.dart';

import '../../pages/pages.dart';

class WgTabBar extends StatelessWidget {
  static final tabs = [
    {
      'title': Text('首页'),
      'icon': Icon(Icons.home),
      'builder': (BuildContext context) => HomePage(),
      'refresh': HomePage.refresh,
    },
    {
      'title': Text('发布'),
      'icon': Icon(Icons.add),
      'builder': (BuildContext context) => PublishPage(),
    },
    {
      'title': Text('我的'),
      'icon': Icon(Icons.account_circle),
      'builder': (BuildContext context) => MePage(),
    },
  ];

  final int currentIndex;

  WgTabBar({
    this.currentIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (tab) {
        SwitchTabNotification(tab).dispatch(context);

        final refresh = tabs[tab]['refresh'] as void Function();
        if (refresh != null && tab == this.currentIndex) refresh();
      },
      items: tabs
          .map(
            (v) => BottomNavigationBarItem(
              icon: v['icon'],
              title: v['title'],
            ),
          )
          .toList(),
    );
  }
}

class SwitchTabNotification extends Notification {
  final int tab;

  SwitchTabNotification(this.tab);
}
