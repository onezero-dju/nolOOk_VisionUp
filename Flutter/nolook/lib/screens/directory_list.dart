import 'package:flutter/material.dart';
import 'package:nolook/controllers/file_selection_controller.dart';
import 'package:provider/provider.dart';
import 'package:nolook/screens/widgets/file.dart';
import 'package:nolook/screens/widgets/file_add.dart';
import 'package:nolook/screens/widgets/folder_add.dart';
import 'package:nolook/screens/widgets/share.dart';

class DirectoryList extends StatelessWidget {
  const DirectoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FileSelectionController(),
      child: Consumer<FileSelectionController>(
        builder: (context, controller, _) {
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
                        onPressed: controller.toggleSelectionMode,
                      ),
                    ],
                  ),
                ],
              ),
              body: Row(
                children: List.generate(
                  4, // 예제 파일 수
                  (index) => File(
                    isSelectionMode: controller.isSelectionMode,
                    index: index,
                    isSelected: controller.selectedFiles.contains(index),
                    onChanged: (value) =>
                        controller.onCheckboxChanged(value, index),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
