import 'package:flutter/material.dart';

class NamedRoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Named Route'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Go'),
          onPressed: () => Navigator.of(context).pushNamed('/back'),
        ),
      ),
    );
  }
}
