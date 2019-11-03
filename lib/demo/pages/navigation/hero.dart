import 'package:flutter/material.dart';

class HeroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero'),
      ),
      body: GestureDetector(
        child: Hero(
          tag: 'imageHero',
          child: Image.asset('assets/demo/lake.jpg'),
        ),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => _DetailPage(),
        )),
      ),
    );
  }
}

class _DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.asset('assets/demo/lake.jpg'),
          ),
        ),
        onTap: () => Navigator.of(context).pop(),
      ),
    );
  }
}
