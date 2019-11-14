import 'package:flutter/material.dart';
import 'package:librenotes/models/note.dart';
import 'package:librenotes/widgets/note_card.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Note> notes = [ // TODO: temporary models for layout design
    Note(id: 1, text: 'Update project roadmap'),
    Note(id: 2, text: 'Buy cookies 🍪🍪🍪'),
    Note(id: 3, text: 'Read Flutter docs!\nhttps://flutter.dev/docs'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: _getBody(),
    );
  }

  _getBody() {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        var pos = notes.length - 1 - index;
        return _buildNoteItem(context, pos);
      },
    );
  }

  _buildNoteItem(context, int pos) {
    var note = notes[pos];

    return Dismissible(
      key: Key(note.id.toString()),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8, top: 8, right: 8),
              child: NoteCard(
                note: note,
                onTap: () {
                  Navigator.pushNamed(context, 'notes/edit', arguments: note);
                },
              ),
            ),
          ),
        ],
      ),
      onDismissed: (direction) {
        setState(() {
          notes.removeAt(pos);
        });

        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Note removed')));
      },
    );
  }
}
