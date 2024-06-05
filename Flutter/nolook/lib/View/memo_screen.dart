import 'package:flutter/material.dart';
import 'package:nolook/Controller/directory_controller.dart';
import 'package:nolook/Model/titleEditor.dart';
import 'package:nolook/widgets/title.dart';
import 'package:provider/provider.dart';

import 'package:nolook/widgets/content.dart';
import 'package:nolook/widgets/comment.dart';
import 'package:nolook/widgets/file_add.dart';
import 'package:nolook/widgets/file_delete_icon.dart';
import 'package:nolook/widgets/folder_add.dart';
import 'package:nolook/widgets/folder_move.dart';
import 'package:nolook/widgets/share.dart';

class MemoScreen extends StatefulWidget {
  const MemoScreen({super.key});

  @override
  _MemoScreenState createState() => _MemoScreenState();
}

class _MemoScreenState extends State<MemoScreen> {
  late final TextEditingController _titlecontroller;
  late final TextEditingController _contentcontroller;
  final DirectoryController _directoryController = DirectoryController();
  List<String> dirList = [];

  @override
  void initState() {
    super.initState();
    fetchDirList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _titlecontroller = const TitleEditor().getController(context)!;
    _contentcontroller = const Content().getController(context)!;
  }

  Future<void> fetchDirList() async {
    try {
      final fetchedDirList = await _directoryController.fetchDirList();
      if (mounted) {
        setState(() {
          dirList = fetchedDirList;
        });
      }
    } catch (error) {
      print('Error fetching directory list: $error');
    }
  }

  Future<void> saveDirectory() async {
    try {
      print('Trying to save directory with title: ${_titlecontroller.text}');
      await _directoryController.createDirectory(_contentcontroller.text);
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
    try {
      print(
          'Trying to save memo with title: ${_titlecontroller.text} and content: ${_contentcontroller.text}');
      // await _directoryController.saveMemo(,_titlecontroller.text,_contentcontroller.text); //디렉터리 id 넣어야 함
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
    return ChangeNotifierProvider(
      create: (_) => TitleEditorModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
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
                  Share(),
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
                      const Comment(),
                      ElevatedButton(
                        onPressed: saveDirectory,
                        child: const Text('저장'),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: dirList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('File: ${dirList[index]}'),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
