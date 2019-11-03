import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter in Practice'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Spacer(flex: 4),
          Text(
            '叽歪课程 - Flutter 移动应用开发实战',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.title,
          ),
          Text(
            'by 天火@blog.jaggerwang.net',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
          ),
          Spacer(),
          Text(
            'run flutter demo',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
          ),
          Text(
            'flutter run -t lib/demo/main.dart',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subhead,
          ),
          Spacer(),
          Text(
            'run weiguan',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
          ),
          Text(
            'flutter run -t lib/weiguan/mobile/main.dart',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subhead,
          ),
          Spacer(flex: 4),
        ],
      ),
    );
  }
}

class FipApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter in Practice',
      home: HomePage(),
    );
  }
}

void main() => runApp(FipApp());
