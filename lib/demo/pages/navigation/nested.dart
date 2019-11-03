import 'dart:async';

import 'package:flutter/material.dart';

class NestedNavigationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nested Navigation'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Sign Up'),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => _SignUpPage(),
          )),
        ),
      ),
    );
  }
}

class _SignUpPage extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  Future<bool> _onWillPop() async {
    final maybePop = await _navigatorKey.currentState.maybePop();
    return Future.value(!maybePop);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Navigator(
        key: _navigatorKey,
        initialRoute: 'signup/username',
        onGenerateRoute: (settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case 'signup/username':
              builder = (_) => _UsernamePage();
              break;
            case 'signup/password':
              builder = (_) => _PasswordPage();
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),
    );
  }
}

class _UsernamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Username'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Please input username'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(),
                child: Text('Back'),
              ),
              RaisedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed('signup/password'),
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Please input password'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Back'),
              ),
              RaisedButton(
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(),
                child: Text('Finish'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
