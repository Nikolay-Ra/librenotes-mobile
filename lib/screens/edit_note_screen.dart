import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:librenotes/models/note.dart';

class EditNoteScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<EditNoteScreen> {
  Note note;

  final noteTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      note = ModalRoute.of(context).settings.arguments;
      noteTextController.text = note.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: TextField(
              autofocus: true,
              expands: true,
              maxLines: null,
              controller: noteTextController,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.all(8),
                border: InputBorder.none,
                hintText: 'Write your note here',
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _getFloatingActionButton(),
    );
  }

  _getFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.save),
      foregroundColor: Colors.white,
      onPressed: () {},
    );
  }
}
