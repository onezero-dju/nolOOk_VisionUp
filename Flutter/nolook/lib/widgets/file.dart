import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

// File 아이콘에 대한 클래스
class FileWidget extends StatelessWidget {
  const FileWidget({
    super.key,
    required this.memoName,
    required this.isSelectionMode,
    required this.index,
    required this.onChanged,
  });
  final String memoName;
  final bool isSelectionMode;
  final int index;

  final ValueChanged<bool?> onChanged;
  Future<void> saveAsMarkdown(BuildContext context) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/$memoName.md';
      final file = File(path);
      await file
          .writeAsString('# $memoName\n\nThis is the content of the memo.');

      print(path);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving file: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          child: SingleChildScrollView(
            child: Column(
              children: [
                IconButton(
                  onPressed: () async {
                    await saveAsMarkdown(context);
                  },
                  icon: Column(
                    children: [
                      Icon(
                        Icons.insert_drive_file,
                        size: MediaQuery.of(context).size.width * 0.2,
                        color: Colors.blue,
                      ),
                      Text(memoName), // Display directory name here
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isSelectionMode)
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.03,
            left: MediaQuery.of(context).size.width * 0.06,
            child: Checkbox(
              fillColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return const Color.fromARGB(255, 8, 12, 204);
                }
                return null;
              }),
              onChanged: onChanged,
              value: null,
            ),
          ),
      ],
    );
  }
}
