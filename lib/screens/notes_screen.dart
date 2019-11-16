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

  String version = 'version unknown';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      drawer: _getDrawer(),
      body: _getBody(),
      floatingActionButton: _getFloatingActionButton(),
    );
  }

  _getDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Icon(
                Icons.event_note,
                color: Theme.of(context).accentColor,
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          SwitchListTile(
            title: Text('Dark Theme'),
            value: true,
            secondary: Icon(Icons.lightbulb_outline),
            onChanged: (bool value) { },
          ),
          Divider(),
          ListTile(
            title: Text('Visit app page'),
            leading: Icon(Icons.info_outline),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              version,
              textAlign: TextAlign.end,
            ),
            enabled: false,
          ),
        ],
      ),
    );
  }

  _getFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      foregroundColor: Colors.white,
      onPressed: () {},
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
