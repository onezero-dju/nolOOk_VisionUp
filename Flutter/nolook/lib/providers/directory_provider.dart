import 'package:flutter/material.dart';
import 'package:nolook/Controller/directory_controller.dart';

class DirectoryProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _dirList = [];
  final DirectoryController _directoryController = DirectoryController();

  List<Map<String, dynamic>> get dirList => _dirList;

  Future<void> fetchDirList() async {
    try {
      final fetchedDirList = await _directoryController.fetchDirList();
      _dirList = fetchedDirList.cast<Map<String, dynamic>>();
      notifyListeners();
    } catch (error) {
      print('Error fetching directory list: $error');
    }
  }
}
