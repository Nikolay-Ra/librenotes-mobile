import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LibreNotes',
      home: Scaffold(
        appBar: AppBar(
          title: Text('LibreNotes')
        ),
        body: Center(
          child: Text('Hello, World!'),
        ),
      ),
    );
  }
}
