import 'package:flutter/material.dart';
import 'package:nolook/Controller/directory_controller.dart';
import 'package:nolook/providers/file_selection_provider.dart';
import 'package:nolook/widgets/file.dart';
import 'package:nolook/widgets/file_add.dart';
import 'package:nolook/widgets/folder_add.dart';
import 'package:nolook/widgets/share.dart';
import 'package:provider/provider.dart';

// Controller import
//디렉터리 구조를 확인하는 파일이다.
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
    } catch (error) {
      // 에러 처리
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
                  2, // dirList.length, // dir_list의 길이만큼 생성
                  (index) => ElevatedButton(
                    onPressed: () async {
                      // await _directoryController.viewDirectory();  파일에 해당하는 id값
                    },
                    child: File(
                      isSelectionMode: controller.isSelectionMode,
                      index: index,
                      isSelected: controller.selectedFiles.contains(index),
                      onChanged: (value) =>
                          controller.onCheckboxChanged(value, index),
                    ),
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
