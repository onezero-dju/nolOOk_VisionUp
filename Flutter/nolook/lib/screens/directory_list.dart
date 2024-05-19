import 'package:flutter/material.dart';
import 'package:nolook/screens/widgets/check.dart';
import 'package:nolook/screens/widgets/file.dart';
import 'package:nolook/screens/widgets/file_add.dart';
import 'package:nolook/screens/widgets/folder_add.dart';
import 'package:nolook/screens/widgets/share.dart';

class DirectoryList extends StatefulWidget {
  const DirectoryList({super.key});

  @override
  _DirectoryListState createState() => _DirectoryListState();
}

class _DirectoryListState extends State<DirectoryList> {
  bool _isSelectionMode = false;
  final Set<int> _selectedFiles = {};

  void _toggleSelectionMode() {
    setState(() {
      _isSelectionMode = !_isSelectionMode;
      if (!_isSelectionMode) {
        _selectedFiles.clear();
      }
    });
  }

  void _onCheckboxChanged(bool? value, int index) {
    setState(() {
      if (value == true) {
        _selectedFiles.add(index);
      } else {
        _selectedFiles.remove(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: const FolderAdd(),
          actions: [
            Row(
              children: [
                const FileAdd(),
                const Share(),
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: _toggleSelectionMode,
                ),
              ],
            ),
          ],
        ),
        body: Row(
          children: List.generate(
            4, // 예제 파일 수
            (index) => File(
              isSelectionMode: _isSelectionMode,
              index: index,
              isSelected: _selectedFiles.contains(index),
              onChanged: (value) => _onCheckboxChanged(value, index),
            ),
          ),
        ),
      ),
    );
  }
}
