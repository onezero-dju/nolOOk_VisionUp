import 'package:flutter/material.dart';
import 'package:nolook/Controller/directory_controller.dart';
import 'package:nolook/providers/file_selection_provider.dart';
import 'package:provider/provider.dart';

// FileDeleteIcon 아이콘에 대한 클래스
class FileDeleteIcon extends StatelessWidget {
  FileDeleteIcon({super.key});
  final DirectoryController _directoryController = DirectoryController();

  Future<void> deleteSelectedDirectories(Set<int> directoryIds) async {
    try {
      print(directoryIds);
      await _directoryController.deleteSelectedDirectories(directoryIds);
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final selectedFiles =
            Provider.of<FileSelectionController>(context, listen: false)
                .selectedDirectoryIds;

        if (selectedFiles.isEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '폴더를 선택해주세요',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      '확인',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Directory'),
                content: const Text('정말로 삭제하시겠습니까?'),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          '취소',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          await deleteSelectedDirectories(selectedFiles);
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          '확인',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        }
      },
      icon: Icon(
        Icons.delete,
        size: MediaQuery.of(context).size.width * 0.13,
        color: Colors.blue,
      ),
    );
  }
}
