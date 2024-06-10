import 'package:flutter/material.dart';
import 'package:nolook/Controller/directory_controller.dart';
import 'package:nolook/Model/contentEdItor.dart';
import 'package:nolook/Model/gpt.dart';
import 'package:nolook/Model/titleEditor.dart';
import 'package:nolook/View/directory_list.dart';
import 'package:nolook/providers/selected_directory_provider.dart';
import 'package:nolook/widgets/share.dart';
import 'package:provider/provider.dart';
import 'package:nolook/widgets/content.dart';
import 'package:nolook/widgets/file_add.dart';
import 'package:nolook/widgets/folder_add.dart';
import 'package:nolook/widgets/folder_move.dart';
import 'package:nolook/widgets/title.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      backgroundColor: const Color.fromARGB(255, 242, 243, 235),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 233, 233, 230),
        leadingWidth: 5000,
        leading: const Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FolderMove(),
            ],
          ),
        ),
        actions: [
          Row(
            children: [
              const FolderAdd(),
              const Share(),
              GestureDetector(
                onTap: () {
                  saveMemo();
                  _titlecontroller.clear(); // 제목 텍스트 초기화
                  _contentcontroller.clear(); // 내용 텍스트 초기화
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const MemoScreen(),
                    ),
                  );
                },
                child: const FileAdd(),
              ),
            ],
          ),
        ],
      ),
      body: const Column(
        children: [
          Divider(
            height: 4,
            thickness: 1.4,
            color: Color.fromARGB(255, 200, 211, 161),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TitleEditor(),
                  Divider(
                    height: 10,
                    thickness: 1.4,
                    color: Color.fromARGB(255, 200, 211, 161),
                  ),
                  Content(),
                  // Divider(
                  //   height: 1,
                  //   thickness: 1,
                  //   color: Colors.black,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     OutlinedButton(
                  //       onPressed: () {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => const DirectoryList(),
                  //           ),
                  //         );
                  //       },
                  //       child: const Text(
                  //         '취소',
                  //         style: TextStyle(
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: MediaQuery.of(context).size.width * 0.04,
                  //     ),
                  //     OutlinedButton(
                  //       onPressed: saveDirectory,
                  //       child: const Text(
                  //         '저장',
                  //         style: TextStyle(
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
