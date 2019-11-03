import 'package:flutter/material.dart';

class HoriVertAlignPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horizontal and Vertical Align'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/demo/small-pic-1.jpg'),
            Image.asset('assets/demo/small-pic-2.jpg'),
            Image.asset('assets/demo/small-pic-3.jpg'),
          ],
        ),
      ),
    );
  }
}
