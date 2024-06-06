import 'package:flutter/material.dart';
import 'package:nolook/Controller/directory_controller.dart';
import 'package:nolook/Model/contentEdItor.dart';
import 'package:nolook/Model/titleEditor.dart';
import 'package:nolook/View/directory_list.dart';
import 'package:nolook/providers/selected_directory_provider.dart';
import 'package:provider/provider.dart';
import 'package:nolook/widgets/content.dart';
import 'package:nolook/widgets/comment.dart';
import 'package:nolook/widgets/file_add.dart';
import 'package:nolook/widgets/file_delete_icon.dart';
import 'package:nolook/widgets/folder_add.dart';
import 'package:nolook/widgets/folder_move.dart';
import 'package:nolook/widgets/share.dart';
import 'package:nolook/widgets/title.dart';

class MemoScreen extends StatefulWidget {
  const MemoScreen({super.key});

  @override
  _MemoScreenState createState() => _MemoScreenState();
}

class _MemoScreenState extends State<MemoScreen> {
  late TextEditingController _titlecontroller;
  late TextEditingController _contentcontroller;
  final DirectoryController _directoryController = DirectoryController();
  List<dynamic> dirList = [];

  @override
  void initState() {
    super.initState();
    fetchDirList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _titlecontroller =
        Provider.of<TitleEditorModel>(context, listen: false).controller;
    _contentcontroller =
        Provider.of<ContentEditorModel>(context, listen: false).controller;
  }

  Future<void> fetchDirList() async {
    try {
      final fetchedDirList = await _directoryController.fetchDirList();
      setState(() {
        dirList = List<Map<String, dynamic>>.from(fetchedDirList);
      });

      if (dirList.isNotEmpty) {
        final selectedDirectoryProvider =
            Provider.of<SelectedDirectoryProvider>(context, listen: false);
        selectedDirectoryProvider.setSelectedDirectoryId(dirList[1]['id']);
      }

      print("dirlist: $dirList");
    } catch (error) {
      print('Error fetching directory list: $error');
    }
  }

  Future<void> saveDirectory() async {
    try {
      print('Trying to save directory with title: ${_titlecontroller.text}');
      await _directoryController.createDirectory(_titlecontroller.text);
      if (mounted) {
        await fetchDirList(); // 디렉토리 생성 후 dirList 업데이트
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create directory: $error')),
        );
      }
      print('Error: $error');
    }
  }

  Future<void> saveMemo() async {
    final selectedDirectoryId =
        Provider.of<SelectedDirectoryProvider>(context, listen: false)
            .selectedDirectoryId;
    try {
      print(
          'Trying to save memo with title: ${_titlecontroller.text} and content: ${_contentcontroller.text} and id is $selectedDirectoryId');
      await _directoryController.saveMemo(selectedDirectoryId!,
          _titlecontroller.text, _contentcontroller.text); // 디렉터리 id 넣어야 함
      if (mounted) {
        await fetchDirList(); // 디렉토리 생성 후 dirList 업데이트
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create memo: $error')),
        );
      }
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 200,
        leading: const Row(
          children: [
            FolderMove(),
            FolderAdd(),
          ],
        ),
        actions: [
          Row(
            children: [
              const FileAdd(),
              const Share(),
              FileDeleteIcon(),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          const Divider(
            height: 1,
            thickness: 1,
            color: Colors.black,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const TitleEditor(),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.black,
                  ),
                  const Content(),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DirectoryList(),
                            ),
                          );
                        },
                        child: const Text(
                          '취소',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.04,
                      ),
                      OutlinedButton(
                        onPressed: saveMemo,
                        child: const Text(
                          '저장',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
