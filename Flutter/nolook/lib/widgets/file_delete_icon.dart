import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nolook/Controller/directory_controller.dart';
import 'package:nolook/View/directory_list.dart';
import 'package:nolook/providers/file_selection_provider.dart';
import 'package:provider/provider.dart';

// FileDeleteIcon 아이콘에 대한 클래스
class FileDeleteIcon extends StatefulWidget {
  const FileDeleteIcon({super.key});

  @override
  State<FileDeleteIcon> createState() => _FileDeleteIconState();
}

class _FileDeleteIconState extends State<FileDeleteIcon> {
  final DirectoryController _directoryController = DirectoryController();
  @override
  void initState() {
    super.initState();
  }

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
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.17,
      child: IconButton(
        onPressed: () {
          final selectedFiles =
              Provider.of<FileSelectionController>(context, listen: false)
                  .selectedDirectoryIds;

          if (selectedFiles.isEmpty) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: const Color.fromARGB(255, 233, 233, 230),
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
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const DirectoryList(),
                              ),
                            );
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
        icon: SvgPicture.asset(
          'assets/images/Delete.svg',
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
