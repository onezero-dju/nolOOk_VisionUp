import 'package:flutter/material.dart';

class FileSelectionController extends ChangeNotifier {
  bool _isSelectionMode = false;
  final Set<int> _selectedDirectoryIds = {};

  bool get isSelectionMode => _isSelectionMode;
  Set<int> get selectedDirectoryIds => _selectedDirectoryIds;

  void toggleSelectionMode() {
    _isSelectionMode = !_isSelectionMode;
    if (!_isSelectionMode) {
      _selectedDirectoryIds.clear();
    }
    notifyListeners();
  }

  void disableSelectionMode() {
    _isSelectionMode = false;
    notifyListeners();
  }

  void onCheckboxChanged(bool? value, int directoryId) {
    if (value == true) {
      _selectedDirectoryIds.add(directoryId);
    } else {
      _selectedDirectoryIds.remove(directoryId);
    }
    notifyListeners();
  }
}
