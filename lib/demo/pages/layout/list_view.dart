import 'package:flutter/material.dart';

class ListViewPage extends StatelessWidget {
  final theaters = [
    {
      'title': 'CineArts at the Empire',
      'subtitle': '85 W Portal Ave',
    },
    {
      'title': 'The Castro Theater',
      'subtitle': '429 Castro St',
    },
    {
      'title': 'Alamo Drafthouse Cinema',
      'subtitle': '2550 Mission St',
    },
    {
      'title': 'Roxie Theater',
      'subtitle': '3117 16th St',
    },
    {
      'title': 'United Artists Stonestown Twin',
      'subtitle': '501 Buckingham Way',
    },
    {
      'title': 'AMC Metreon 16',
      'subtitle': '135 4th St #3000',
    },
  ];

  final restaurants = [
    {
      'title': 'K\'s Kitchen',
      'subtitle': '757 Monterey Blvd',
    },
    {
      'title': 'Emmy\'s Restaurant',
      'subtitle': '1923 Ocean Ave',
    },
    {
      'title': 'Chaiya Thai Restaurant',
      'subtitle': '272 Claremont Blvd',
    },
    {
      'title': 'La Ciccia',
      'subtitle': '291 30th St',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final items = theaters
        .map<Widget>((theater) => ListTile(
              title: Text(
                theater['title'],
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              subtitle: Text(theater['subtitle']),
              leading: Icon(
                Icons.theaters,
                color: Colors.blue[500],
              ),
            ))
        .toList();

    items.add(Divider());

    items.addAll(restaurants.map((restaurant) => ListTile(
          title: Text(
            restaurant['title'],
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          subtitle: Text(restaurant['subtitle']),
          leading: Icon(
            Icons.restaurant,
            color: Colors.blue[500],
          ),
        )));

    return Scaffold(
      appBar: AppBar(
        title: Text('List View'),
        elevation: 5,
      ),
      body: Center(
        child: ListView(
          children: items,
        ),
      ),
    );
  }
}
