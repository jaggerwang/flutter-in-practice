import 'package:flutter/material.dart';

class ReturnDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Return Data'),
      ),
      body: Builder(
        builder: (context) => Center(
          child: RaisedButton(
            onPressed: () async {
              final result = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => _SelectionPage(),
              ));

              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('$result')));
            },
            child: Text('Pick an option, any option!'),
          ),
        ),
      ),
    );
  }
}

class _SelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick an option'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: RaisedButton(
                onPressed: () => Navigator.of(context).pop('Yep!'),
                child: Text('Yep!'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: RaisedButton(
                onPressed: () => Navigator.of(context).pop('Nope.'),
                child: Text('Nope.'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
