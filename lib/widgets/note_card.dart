import 'package:flutter/material.dart';
import 'package:librenotes/models/note.dart';

class NoteCard extends StatelessWidget {
  static const textStyle = TextStyle(fontSize: 16);
  static const timeStyle = TextStyle(fontSize: 12, color: Colors.grey);

  final Note note;
  final Function onTap;

  const NoteCard({@required this.note, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                note.text,
                style: textStyle,
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'not synced',
                      style: timeStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
