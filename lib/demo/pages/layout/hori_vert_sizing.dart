import 'package:flutter/material.dart';

class HoriVertSizingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horizontal and Vertical Sizing'),
      ),
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: Image.asset(
                'assets/demo/small-pic-1.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 2,
              child: Image.asset(
                'assets/demo/small-pic-2.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Image.asset(
                'assets/demo/small-pic-3.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
