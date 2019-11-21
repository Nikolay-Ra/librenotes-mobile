import 'package:librenotes/models/tag.dart';
import 'package:meta/meta.dart';

class Note {
  final int id;
  final DateTime created;
  final List<Tag> tags;
  final String text;

  Note({@required this.id, DateTime created, List<Tag> tags, this.text: ''}) :
    this.created = created ?? DateTime.now(),
    this.tags = List.unmodifiable(tags ?? []);
}
