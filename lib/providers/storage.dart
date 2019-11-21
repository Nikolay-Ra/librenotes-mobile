import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:librenotes/models/note.dart';
import 'package:librenotes/models/tag.dart';

class Storage with ChangeNotifier {
  List<Note> _notes = [];
  List<Tag> _tags = [];

  get notes => UnmodifiableListView(_notes);
  get tags => UnmodifiableListView(_tags);

  Storage() {
    _tags.addAll([
      Tag(id: 1, name: 'TODO'),
      Tag(id: 2, name: 'Work'),
      Tag(id: 3, name: 'Study'),
    ]);

    _notes.addAll([
      Note(id: 1, text: 'Update project roadmap', tags: [_tags[0], _tags[1], _tags[2]]),
      Note(id: 2, text: 'Buy cookies 🍪🍪🍪'),
      Note(id: 3, text: 'Read Flutter docs!\nhttps://flutter.dev/docs', tags: [_tags[1]]),
    ]);
  }

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void saveNote(Note note) {
    int index = _notes.indexWhere((second) => second.id == note.id);
    _notes[index] = note;
    notifyListeners();
  }

  void deleteNote(int id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  void addTag(Tag tag) {
    _tags.add(tag);
    notifyListeners();
  }
}
