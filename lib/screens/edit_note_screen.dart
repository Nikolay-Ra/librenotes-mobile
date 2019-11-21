import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:librenotes/models/note.dart';
import 'package:librenotes/models/tag.dart';
import 'package:librenotes/providers/storage.dart';
import 'package:librenotes/widgets/add_tag_dialog.dart';
import 'package:librenotes/widgets/tag_button.dart';
import 'package:librenotes/widgets/toggle_tag.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class EditNoteScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<EditNoteScreen> {
  Note note;

  final noteTextController = TextEditingController();

  Storage storage;
  List<bool> tagsState;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      noteTextController.text = note?.text;
    });
  }

  @override
  void didChangeDependencies() {
    storage = Provider.of<Storage>(context);
    note = ModalRoute.of(context).settings.arguments;
    tagsState ??= List<bool>.generate(storage.tags.length, (i) => note?.tags?.contains(storage.tags[i]) ?? false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note == null ? 'Add' : 'Edit'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _onShare,
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

  _onShare() {
    Share.share(note.text);
  }

  _getTagSelector() {
    return Container(
      padding: EdgeInsets.all(8),
      color: Theme.of(context).cardColor,
      child: Row(
        children: <Widget>[
          for (var i = 0; i < storage.tags.length; i++)
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: ToggleTag(
              name: storage.tags[i].name,
              active: tagsState[i],
              onTap: () => _onTapTag(i),
            ),
          ),
          TagButton(
            name: ' + ',
            onTap: _onAddTag,
          ),
        ],
      ),
    );
  }

  _onTapTag(int pos) {
    setState(() {
      tagsState[pos] = !tagsState[pos];
    });
  }

  _onAddTag() {
    showDialog(
      context: context,
      builder: (_) {
        return AddTagDialog();
      },
    ).then((result) {
      if (result == null)
        return;

      setState(() {
        storage.addTag(Tag(id: 0, name: result));
        tagsState.add(true);
      });
    });
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

  Note _toNote() {
    List<Tag> tags = [];
    for (int i = 0; i < tagsState.length; i++) {
      if (tagsState[i]) {
        tags.add(storage.tags[i]);
      }
    }

    return Note(
      id: note?.id,
      tags: tags,
      text: noteTextController.text,
    );
  }

  _getFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.save),
      foregroundColor: Colors.white,
      onPressed: () {
        Note result = _toNote();
        if (note == null) {
          storage.addNote(result);
        } else {
          storage.saveNote(result);
        }
        Navigator.of(context).pop();
      },
    );
  }
}
