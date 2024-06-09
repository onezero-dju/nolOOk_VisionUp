import 'package:flutter/material.dart';
import 'package:nolook/Controller/directory_controller.dart';
import 'package:nolook/providers/file_selection_provider.dart';
import 'package:nolook/widgets/file_add.dart';
import 'package:nolook/widgets/folder_add.dart';
import 'package:nolook/widgets/share.dart';
import 'package:provider/provider.dart';
import 'package:nolook/widgets/file.dart';

// Controller import
// 디렉터리 구조를 확인하는 파일이다.
class FileList extends StatefulWidget {
  final int directoryId;

  const FileList({super.key, required this.directoryId});

  @override
  _FileListState createState() => _FileListState();
}

class _FileListState extends State<FileList> {
  List<dynamic> memoList = [];
  final DirectoryController _directoryController = DirectoryController();

  @override
  void initState() {
    super.initState();
    viewDirectory(widget.directoryId);
  }

  Future<void> viewDirectory(int directoryId) async {
    try {
      final viewDirectoryList =
          await _directoryController.viewDirectory(directoryId);
      setState(() {
        memoList = viewDirectoryList;
      });
      print("memoList: $memoList");
    } catch (error) {
      print('Error fetching directory list: $error');
    }
  }

  Future<void> viewMemo(int memoId) async {
    try {
      final viewMemoDetails = await _directoryController.viewMemo(memoId);
      // 단일 메모 처리
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(viewMemoDetails['memoName']),
            content: Text(viewMemoDetails['content']),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
      print("memoDetails: $viewMemoDetails");
    } catch (error) {
      print('Error fetching memo details: $error');
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
              body: memoList.isEmpty
                  ? const Center(child: Text('No memos found'))
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // 한 줄에 3개의 아이템을 배치
                        childAspectRatio: 1, // 각 아이템의 가로 세로 비율을 1:1로 설정
                      ),
                      itemCount: memoList.length, // memoList의 길이만큼 생성
                      itemBuilder: (context, index) {
                        final memo = memoList[index];
                        final memoName = memo['memoName'];
                        final memoId = memo['memoId'] as int?;
                        // Check if memoId is null and handle it
                        return ElevatedButton(
                          onPressed: () {
                            viewMemo(memoId!); // memoId를 전달
                          },
                          child: FileWidget(
                            memoName: memoName,
                            isSelectionMode: controller.isSelectionMode,
                            index: index,
                            onChanged: (value) =>
                                controller.onCheckboxChanged(value, index),
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
