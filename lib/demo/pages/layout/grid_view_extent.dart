import 'package:flutter/material.dart';

class GridViewExtentPage extends StatelessWidget {
  Widget buildGrid() {
    return GridView.extent(
      maxCrossAxisExtent: 150,
      padding: const EdgeInsets.all(4),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: List.generate(
        30,
        (index) => Container(
          child: Image.asset(
            'assets/demo/middle-pic-${index + 1}.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid View Extent'),
      ),
      body: Center(
        child: buildGrid(),
      ),
    );
  }
}
