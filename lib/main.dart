import 'package:flutter/material.dart';
import 'package:librenotes/routes.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LibreNotes',
      initialRoute: initialRoute,
      routes: routes,
    );
  }
}
