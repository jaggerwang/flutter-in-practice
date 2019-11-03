import 'dart:async';

import 'package:flutter/material.dart';

class RefreshIndicatorPage extends StatefulWidget {
  @override
  _RefreshIndicatorPageState createState() => _RefreshIndicatorPageState();
}

class _RefreshIndicatorPageState extends State<RefreshIndicatorPage> {
  final _controller = ScrollController();

  Future _refresh() {
    final completer = Completer();
    Future.delayed(Duration(seconds: 2), () {
      completer.complete();
    });
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    final items = List.generate(100, (i) => i + 1).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Refresh Indicator'),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          controller: _controller,
          itemCount: items.length,
          itemBuilder: (context, index) => ListTile(
            title: Text('Item ${items[index]}'),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _controller.animateTo(
          0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        ),
        child: Icon(Icons.arrow_upward, color: Colors.white),
      ),
    );
  }
}
