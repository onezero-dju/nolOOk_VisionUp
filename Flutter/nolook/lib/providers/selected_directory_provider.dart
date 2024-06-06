import 'package:flutter/material.dart';

class SelectedDirectoryProvider extends ChangeNotifier {
  int? _selectedDirectoryId;

  int? get selectedDirectoryId => _selectedDirectoryId;

  void setSelectedDirectoryId(int id) {
    _selectedDirectoryId = id;
    notifyListeners();
  }
}
