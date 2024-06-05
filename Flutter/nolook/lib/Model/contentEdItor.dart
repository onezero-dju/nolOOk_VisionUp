import 'package:flutter/material.dart';

class ContentEditorModel extends ChangeNotifier {
  final TextEditingController _controller = TextEditingController();

  TextEditingController get controller => _controller;

  String get text => _controller.text;

  set text(String newText) {
    _controller.text = newText;
    notifyListeners();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
