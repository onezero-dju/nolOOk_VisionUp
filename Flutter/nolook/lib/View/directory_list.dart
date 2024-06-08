import 'package:flutter/material.dart';
import 'package:nolook/Controller/directory_controller.dart';
import 'package:nolook/View/file_list.dart';
import 'package:nolook/providers/file_selection_provider.dart';
import 'package:nolook/widgets/directory_name_change_icon.dart';
import 'package:nolook/widgets/file_delete_icon.dart';
import 'package:nolook/widgets/folder.dart';
import 'package:nolook/widgets/file_add.dart';
import 'package:nolook/widgets/folder_add.dart';
import 'package:nolook/widgets/share.dart';
import 'package:provider/provider.dart';
import 'package:nolook/widgets/file.dart';

class DirectoryList extends StatefulWidget {
  const DirectoryList({super.key});

  @override
  _DirectoryListState createState() => _DirectoryListState();
}

class _DirectoryListState extends State<DirectoryList> {
  List<dynamic> dirList = [];
  final DirectoryController _directoryController = DirectoryController();

  @override
  void initState() {
    super.initState();
    fetchDirList();
  }

  Future<void> fetchDirList() async {
    try {
      final fetchedDirList = await _directoryController.fetchDirList();
      setState(() {
        dirList = fetchedDirList;
      });
      print("dirList: $dirList");
    } catch (error) {
      print('Error fetching directory list: $error');
    }
  }

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
                      const DirectoryNameChangeIcon(),
                      FileDeleteIcon(),
                      IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: controller.toggleSelectionMode,
                      ),
                    ],
                  ),
                ],
              ),
              body: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                ),
                itemCount: dirList.length,
                itemBuilder: (context, index) {
                  final directory = dirList[index];
                  final directoryName = directory['directoryName'];
                  final directoryId = directory['id'] as int;
                  return ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FileList(directoryId: directoryId),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Folder(
                          directoryName: directoryName,
                          isSelectionMode: controller.isSelectionMode,
                          index: directoryId,
                          isSelected: controller.selectedDirectoryIds
                              .contains(directoryId),
                          onChanged: (value) =>
                              controller.onCheckboxChanged(value, directoryId),
                          directoryId: directoryId,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
