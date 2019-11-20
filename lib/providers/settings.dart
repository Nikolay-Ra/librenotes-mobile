import 'package:flutter/widgets.dart';

class Settings with ChangeNotifier {
  bool _dark = true;

  bool get dark => _dark;
  set dark(bool value) {
    _dark = value;
    notifyListeners();
  }
}
