import 'package:flutter/material.dart';

class TitleEditorModel extends ChangeNotifier {
  final TextEditingController _controller = TextEditingController();
  String _text = '';

  TextEditingController get controller => _controller;
  String get text => _text;

  set text(String value) {
    if (value != _text) {
      _text = value;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
