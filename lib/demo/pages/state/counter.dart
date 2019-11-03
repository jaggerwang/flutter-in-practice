import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _CounterModel with ChangeNotifier {
  int value = 0;

  void increment() {
    value += 1;
    notifyListeners();
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('You have pushed the button this many times:'),
          Consumer<_CounterModel>(
            builder: (context, counter, child) => Text(
              '${counter.value}',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () =>
          Provider.of<_CounterModel>(context, listen: false).increment(),
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );
  }
}

class StateCounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => _CounterModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Counter with Provider'),
        ),
        body: _Body(),
        floatingActionButton: _ActionButton(),
      ),
    );
  }
}
