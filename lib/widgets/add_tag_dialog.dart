import 'package:flutter/material.dart';

class AddTagDialog extends StatefulWidget {
  @override
  _AddTagDialogState createState() => _AddTagDialogState();
}

class _AddTagDialogState extends State<AddTagDialog> {
  TextEditingController _tagTextController = TextEditingController();

  String addTagDialogError;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('New tag'),
      content: TextField(
        autofocus: true,
        controller: _tagTextController,
        decoration: InputDecoration(
          hintText: 'Tag',
          errorText: addTagDialogError,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: new Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: new Text('ADD'),
          onPressed: () {
            if (_tagTextController.text.isEmpty) {
              setState(() {
                addTagDialogError = 'Tag can not be empty';
              });
              return;
            }

            Navigator.of(context).pop(_tagTextController.text);
          },
        ),
      ],
    );
  }
}
