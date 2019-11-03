import 'package:flutter/material.dart';

class GridViewCountPage extends StatelessWidget {
  Widget buildGrid(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return GridView.count(
      crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
      padding: const EdgeInsets.all(4),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      childAspectRatio: (orientation == Orientation.portrait) ? 1 : 1.3,
      children: List.generate(
        30,
        (index) => GridTile(
          child: Image.asset(
            'assets/demo/middle-pic-${index + 1}.jpg',
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black45,
            title: Text('Picture ${index + 1}'),
            subtitle: Text('Description of ${index + 1}'),
            trailing: Icon(
              Icons.star_border,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid View Count'),
      ),
      body: Center(
        child: buildGrid(context),
      ),
    );
  }
}
