import 'package:flutter/material.dart';
import 'package:librenotes/models/note.dart';
import 'package:librenotes/providers/settings.dart';
import 'package:librenotes/providers/storage.dart';
import 'package:librenotes/widgets/note_card.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  String version = 'version unknown';

  Settings settings;
  Storage storage;

  @override
  void initState() {
    super.initState();

    PackageInfo.fromPlatform().then(
      (PackageInfo packageInfo) {
        setState(() {
          version = 'v${packageInfo.version}+${packageInfo.buildNumber}';
        });
      }
    );
  }

  @override
  void didChangeDependencies() {
    settings = Provider.of<Settings>(context);
    storage = Provider.of<Storage>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
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
            value: settings.dark,
            secondary: Icon(Icons.lightbulb_outline),
            onChanged: _onThemeSwitch,
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

  _onThemeSwitch(bool value) async {
    settings.dark = value;
  }

  _getFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      foregroundColor: Colors.white,
      onPressed: () {
          Navigator.pushNamed(context, 'notes/edit');
      },
    );
  }

  _getBody() {
    return ListView.builder(
      itemCount: storage.notes.length,
      itemBuilder: (context, index) {
        var pos = storage.notes.length - 1 - index;
        return _buildNoteItem(context, pos);
      },
    );
  }

  _buildNoteItem(context, int pos) {
    Note note = storage.notes[pos];

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
          storage.deleteNote(note.id);
        });

        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Note removed')));
      },
    );
  }
}
