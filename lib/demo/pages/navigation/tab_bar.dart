import 'dart:async';

import 'package:flutter/material.dart';

import '../../components/components.dart';

class TabBarNavigationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TabBar Navigation'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => _TabBarPage(),
          )),
          child: Text('Show Tabs'),
        ),
      ),
    );
  }
}

class _SwitchTabNotification extends Notification {
  final int tab;

  _SwitchTabNotification(this.tab);
}

class _TabBar extends StatelessWidget {
  static final tabs = [
    {
      'title': Text('First'),
      'icon': Icon(Icons.home),
      'builder': (BuildContext context) => _FirstTabPage(),
    },
    {
      'title': Text('Second'),
      'icon': Icon(Icons.add),
      'builder': (BuildContext context) => _SecondTabPage(),
    },
    {
      'title': Text('Third'),
      'icon': Icon(Icons.account_circle),
      'builder': (BuildContext context) => _ThirdTabPage(),
    },
  ];

  final int currentIndex;

  _TabBar({
    Key key,
    this.currentIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (tab) {
        _SwitchTabNotification(tab).dispatch(context);
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

class _TabBarPage extends StatefulWidget {
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<_TabBarPage> {
  static final _navigatorKeys =
      _TabBar.tabs.map((v) => GlobalKey<NavigatorState>()).toList();

  var _tab = 0;

  bool _handleSwitchTabNotification(_SwitchTabNotification notification) {
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
      child: NotificationListener<_SwitchTabNotification>(
        onNotification: _handleSwitchTabNotification,
        child: IndexedStack(
          index: _tab,
          children: _TabBar.tabs
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
                        throw Exception('Invalid route: ${settings.name}');
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

class _FirstTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Tab'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(flex: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => _BackPage(),
                )),
                child: Text('Go'),
              ),
              RaisedButton(
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(),
                child: Text('Back'),
              )
            ],
          ),
          Spacer(),
          Counter(),
          Spacer(flex: 3),
        ],
      ),
      bottomNavigationBar: _TabBar(currentIndex: 0),
    );
  }
}

class _SecondTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Tab'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(flex: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => _BackPage(),
                )),
                child: Text('Go'),
              ),
              RaisedButton(
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(),
                child: Text('Back'),
              )
            ],
          ),
          Spacer(),
          Counter(),
          Spacer(flex: 3),
        ],
      ),
      bottomNavigationBar: _TabBar(currentIndex: 1),
    );
  }
}

class _ThirdTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Tab'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(flex: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => _BackPage(),
                )),
                child: Text('Go'),
              ),
              RaisedButton(
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(),
                child: Text('Back'),
              )
            ],
          ),
          Spacer(),
          Counter(),
          Spacer(flex: 3),
        ],
      ),
      bottomNavigationBar: _TabBar(currentIndex: 2),
    );
  }
}

class _BackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Back'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Back'),
        ),
      ),
    );
  }
}
