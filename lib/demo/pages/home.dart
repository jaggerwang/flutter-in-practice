import 'package:flutter/material.dart';

import '../components/components.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: JWFDDrawer(),
      body: Center(
        child: Text(
          'Flutter Demo',
          style: Theme.of(context).textTheme.display1,
        ),
      ),
    );
  }
}
