import 'package:librenotes/models/note.dart';
import 'package:librenotes/models/tag.dart';
import 'package:sqflite/sqflite.dart';

class Cache {
  Future<Database> database;
  Future<bool> firstOpen;
  bool _created = false;

  Cache() {
    database = openDatabase(
      'cache.db',
      version: 1,
      onCreate: _onCreate,
    );

    firstOpen = _getFirstOpen();
  }

  Future<bool> _getFirstOpen() async {
    await database;
    return _created;
  }

  _onCreate(Database db, int version) {
    _created = true;

    db.execute('''
      CREATE TABLE tag (
        id INTEGER PRIMARY KEY,
        name VARCHAR(255)
      )
    ''');
    db.execute('''
      CREATE TABLE note (
        id INTEGER PRIMARY KEY,
        created DATETIME,
        txt TEXT
      )
    ''');
    db.execute('''
      CREATE TABLE notes_tag (
        note_id INTEGER,
        tag_id INTEGER,
        PRIMARY KEY (note_id, tag_id)
      )
    ''');
  }

  insertDebugData() async {
    await insertTag(Tag(name: 'TODO'));
    await insertTag(Tag(name: 'Work'));
    await insertTag(Tag(name: 'Study'));

    await insertNote(Note(text: 'Update project roadmap', tags: [1, 2, 3]));
    await insertNote(Note(text: 'Buy cookies 🍪🍪🍪'));
    await insertNote(Note(text: 'Read Flutter docs!\nhttps://flutter.dev/docs', tags: [2]));
  }

  Future<List<Note>> notes() async {
    final db = await database;

    final notes = await db.query('note');
    final notesTags = await db.query('notes_tag');

    Map<int, List<int>> tags = {};
    for (var note in notes) {
      tags[note['id']] = [];
    }

    for (var notes_tag in notesTags) {
      final note = notes_tag['note_id'];
      final tag = notes_tag['tag_id'];

      tags[note].add(tag);
    }

    return List.generate(notes.length, (i) {
      Map<String, dynamic> map = Map.from(notes[i]);
      map['tags'] = tags[map['id']];
      return Note.fromMap(map);
    });
  }

  Future<int> insertNote(Note note) async {
    if (note.id != null) {
      throw FormatException('ID of Note model have to be equal to null on insert');
    }

    final db = await database;

    var map = note.toMap();
    List<int> tags = map['tags'];
    map.remove('tags');

    int id = await db.insert('note', map);
    for (var tag in tags) {
      db.insert('notes_tag', {'note_id': id, 'tag_id': tag});
    }

    return id;
  }

  Future<bool> updateNote(Note note) async {
    final db = await database;

    var map = note.toMap();
    List<int> tags = map['tags'];
    map.remove('tags');

    await db.delete(
      'notes_tag',
      where: 'note_id = ?',
      whereArgs: [note.id],
    );

    for (var tag in tags) {
      db.insert('notes_tag', {'note_id': note.id, 'tag_id': tag});
    }

    int result = await db.update(
      'note',
      map,
      where: 'id = ?',
      whereArgs: [note.id],
    );
    return result != 0;
  }

  Future<bool> deleteNote(int id) async {
    final db = await database;

    await db.delete(
      'notes_tag',
      where: 'note_id = ?',
      whereArgs: [id],
    );

    int result = await db.delete(
      'note',
      where: 'id = ?',
      whereArgs: [id]
    );
    return result != 0;
  }

  Future<List<Tag>> tags() async {
    final db = await database;
    final tags = await db.query('tag');

    return List.generate(tags.length, (i) {
      return Tag.fromMap(tags[i]);
    });
  }

  Future<int> insertTag(Tag tag) async {
    if (tag.id != null) {
      throw FormatException('ID of Tag model have to be equal to null on insert');
    }

    final db = await database;

    int id = await db.insert('tag', tag.toMap());
    return id;
  }

  Future<bool> updateTag(Tag tag) async {
    final db = await database;

    int result = await db.update(
      'tag',
      tag.toMap(),
      where: 'id = ?',
      whereArgs: [tag.id],
    );
    return result != 0;
  }

  Future<bool> deleteTag(int id) async {
    final db = await database;

    await db.delete(
      'notes_tag',
      where: 'tag_id = ?',
      whereArgs: [id],
    );

    int result = await db.delete(
      'tag',
      where: 'id = ?',
      whereArgs: [id]
    );
    return result != 0;
  }
}
