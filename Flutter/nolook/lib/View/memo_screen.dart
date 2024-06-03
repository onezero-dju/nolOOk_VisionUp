import 'package:flutter/material.dart';
import 'package:nolook/Controller/directory_controller.dart';
import 'package:nolook/widgets/Markdown.dart';
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
  final DirectoryController _directoryController = DirectoryController();
  List<String> dirList = [];

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
      print('Error fetching directory list: $error');
    }
  }

  Future<void> createFile() async {
    try {
      await _directoryController.createFile('new_file.txt');
      await fetchDirList(); // 파일 생성 후 dirList 업데이트
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create file: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
              color: Colors.black, // 검정색 선
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const MarkdownEditor(),
                    const Comment(),
                    ElevatedButton(
                      onPressed: createFile,
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
    );
  }
}
