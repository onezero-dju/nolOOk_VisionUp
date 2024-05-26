import 'package:flutter/material.dart';

class FileSelectionController extends ChangeNotifier {
  bool _isSelectionMode = false;
  final Set<int> _selectedFiles = {};

  bool get isSelectionMode => _isSelectionMode;
  Set<int> get selectedFiles => _selectedFiles;

  void toggleSelectionMode() {
    _isSelectionMode = !_isSelectionMode;
    if (!_isSelectionMode) {
      _selectedFiles.clear();
    }
    notifyListeners();
  }

  void onCheckboxChanged(bool? value, int index) {
    if (value == true) {
      _selectedFiles.add(index);
    } else {
      _selectedFiles.remove(index);
    }
    notifyListeners();
  }
}
