import 'package:flutter/material.dart';

class ContainerPage extends StatelessWidget {
  Widget _buildImage(String name) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 10, color: Colors.black38),
          borderRadius: const BorderRadius.all(const Radius.circular(8)),
        ),
        margin: const EdgeInsets.all(4),
        child: Image.asset(
          'assets/demo/$name.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var container = Container(
      decoration: BoxDecoration(
        color: Colors.black26,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _buildImage('small-pic-1'),
              _buildImage('small-pic-2'),
            ],
          ),
          Row(
            children: [
              _buildImage('small-pic-3'),
              _buildImage('small-pic-4'),
            ],
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Container'),
      ),
      body: Center(
        child: container,
      ),
    );
  }
}
