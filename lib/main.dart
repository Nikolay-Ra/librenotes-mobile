import 'package:flutter/material.dart';
import 'package:librenotes/routes.dart';
import 'package:librenotes/styles/themes.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LibreNotes',
      theme: dark,
      initialRoute: initialRoute,
      routes: routes,
    );
  }
}
