import 'package:flutter/material.dart';
import 'package:nolook/Controller/directory_controller.dart';
import 'package:nolook/Model/contentEdItor.dart';
import 'package:nolook/Model/gpt.dart';
import 'package:nolook/Model/titleEditor.dart';
import 'package:nolook/View/directory_list.dart';
import 'package:nolook/providers/selected_directory_provider.dart';
import 'package:provider/provider.dart';
import 'package:nolook/widgets/content.dart';
import 'package:nolook/widgets/file_add.dart';
import 'package:nolook/widgets/folder_add.dart';
import 'package:nolook/widgets/folder_move.dart';
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
  final GPTService _gptService = GPTService(); // Initialize the GPT service
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
        selectedDirectoryProvider.setSelectedDirectoryId(dirList[0]['id']);
      }

      print("dirlist: $dirList");
    } catch (error) {
      print('Error fetching directory list: $error');
    }
  }

  Future<void> saveMemo() async {
    final selectedDirectoryProvider =
        Provider.of<SelectedDirectoryProvider>(context, listen: false);
    final String content = _contentcontroller.text;
    print('dd');
    try {
      // Step 1: GPT에서 키워드 추출
      final String keyword = await _gptService.getKeywordFromText(content);
      print('Extracted keyword: $keyword');

      // Step 2: 키워드가 기존 디렉토리 이름에 있는지 확인
      bool directoryExists = false;
      int? directoryId;

      for (var dir in dirList) {
        if (dir['directoryName'] == keyword) {
          directoryExists = true;
          directoryId = dir['id'];
          break;
        }
      }

      if (!directoryExists) {
        // Step 3: 키워드가 기존 디렉토리에 없는 경우
        await _directoryController.createDirectory(keyword);
        await fetchDirList(); // 디렉토리 리스트 갱신
        for (var dir in dirList) {
          if (dir['directoryName'] == keyword) {
            directoryId = dir['id'];
            break;
          }
        }
      }

      // directoryId가 null인지 확인
      if (directoryId == null) {
        throw Exception('Directory ID not found.');
      }

      // 메모 저장
      await _directoryController.saveMemo(
        directoryId,
        _titlecontroller.text,
        _contentcontroller.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Memo saved successfully')),
        );
      }

      // Navigate to DirectoryList screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DirectoryList()),
      );
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save memo: $error')),
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
        actions: const [
          Row(
            children: [
              FileAdd(),
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
