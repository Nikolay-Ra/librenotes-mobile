import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _getLogo(),
            _getForm(),
          ],
        ),
      ),
    );
  }

  _getLogo() {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      padding: EdgeInsets.only(top: 16),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Icon(
          Icons.event_note,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }

  _getForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Server address',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Server address can not be empty';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'User name',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'User name can not be empty';
              }
              return null;
            },
          ),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Password can not be empty';
              }
              return null;
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Navigator.pushReplacementNamed(context, 'notes');
                      }
                    },
                    child: Text('Log In'),
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.blue[900] : Theme.of(context).buttonColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
