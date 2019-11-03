import 'package:flutter/material.dart';

class BasicNavigationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic Navigation'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Go'),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => _BackPage(),
          )),
        ),
      ),
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
