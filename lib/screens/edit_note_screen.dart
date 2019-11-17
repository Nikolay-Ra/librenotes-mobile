import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:librenotes/models/note.dart';
import 'package:librenotes/widgets/tag_button.dart';
import 'package:librenotes/widgets/toggle_tag.dart';

class EditNoteScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<EditNoteScreen> {
  Note note;

  final noteTextController = TextEditingController();

  final tags = ['TODO', 'Work', 'Study'];
  List<bool> tagsState;

  @override
  void initState() {
    super.initState();

    tagsState = List.filled(tags.length, false);

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
          _getTagSelector(),
          _getTextEditor(),
        ],
      ),
      floatingActionButton: _getFloatingActionButton(),
    );
  }

  _getTagSelector() {
    return Container(
      padding: EdgeInsets.all(8),
      color: Theme.of(context).cardColor,
      child: Row(
        children: <Widget>[
          for (var i = 0; i < tags.length; i++)
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: ToggleTag(
              name: tags[i],
              active: tagsState[i],
              onTap: () {
                setState(() {
                  tagsState[i] = !tagsState[i];
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: TagButton(
              name: ' + ',
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  _getTextEditor() {
    return Expanded(
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
