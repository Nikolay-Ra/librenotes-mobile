import 'package:flutter/material.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Edit'),
          onPressed: () {
            Navigator.of(context).pushNamed('notes/edit');
          },
        ),
      ),
    );
  }
}
