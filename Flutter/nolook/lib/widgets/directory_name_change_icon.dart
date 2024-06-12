import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nolook/Controller/directory_controller.dart';
import 'package:nolook/View/directory_list.dart';
import 'package:provider/provider.dart';
import 'package:nolook/providers/file_selection_provider.dart';

// DirectoryNameChangeIcon 아이콘에 대한 클래스
class DirectoryNameChangeIcon extends StatefulWidget {
  const DirectoryNameChangeIcon({super.key});

  @override
  State<DirectoryNameChangeIcon> createState() =>
      _DirectoryNameChangeIconState();
}

class _DirectoryNameChangeIconState extends State<DirectoryNameChangeIcon> {
  List<dynamic> dirList = [];
  final DirectoryController _directoryController = DirectoryController();
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
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.17,
      height: MediaQuery.of(context).size.height * 0.4,
      child: IconButton(
        onPressed: () {
          final fileSelectionController =
              Provider.of<FileSelectionController>(context, listen: false);

          if (fileSelectionController.selectedDirectoryIds.isEmpty) {
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
            final selectedDirectoryId =
                fileSelectionController.selectedDirectoryIds.first;
            showDialog(
              context: context,
              builder: (BuildContext context) {
                String newName = '';
                return AlertDialog(
                  backgroundColor: const Color.fromARGB(255, 233, 233, 230),
                  title: const Text('폴더 이름 변경'),
                  content: TextFormField(
                    onChanged: (value) {
                      newName = value;
                    },
                    decoration: const InputDecoration(
                      hintText: '새 이름을 입력하세요',
                    ),
                  ),
                  actions: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.24,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(70),
                          ),
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor:
                              const Color.fromARGB(255, 226, 226, 193),
                        ),
                        child: const Text(
                          '취소',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.24,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: OutlinedButton(
                        onPressed: () async {
                          if (newName.isNotEmpty) {
                            await Provider.of<DirectoryController>(context,
                                    listen: false)
                                .directoryNameChange(
                                    selectedDirectoryId, newName);

                            Navigator.of(context).pop();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const DirectoryList(),
                              ),
                            );
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(70),
                          ),
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor:
                              const Color.fromARGB(255, 226, 226, 193),
                        ),
                        child: const Text(
                          '확인',
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
        icon: SvgPicture.asset(
          'assets/images/Modify.svg',
          width: MediaQuery.of(context).size.width * 0.09,
          height: MediaQuery.of(context).size.height * 0.2,
        ),
      ),
    );
  }
}
