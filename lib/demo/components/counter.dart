import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  var _num = 0;

  void _substract() {
    setState(() {
      _num -= 1;
    });
  }

  void _add() {
    setState(() {
      _num += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RaisedButton(
          onPressed: _substract,
          child: Text('-'),
        ),
        Text(_num.toString()),
        RaisedButton(
          onPressed: _add,
          child: Text('+'),
        ),
      ],
    );
  }
}
