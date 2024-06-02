import 'package:flutter/material.dart';
import 'package:nolook/widgets/Markdown.dart';
import 'package:nolook/widgets/comment.dart';
import 'package:nolook/widgets/file_add.dart';
import 'package:nolook/widgets/file_delete_icon.dart';
import 'package:nolook/widgets/folder_add.dart';
import 'package:nolook/widgets/folder_move.dart';
import 'package:nolook/widgets/share.dart';

class MemoScreen extends StatelessWidget {
  const MemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            AppBar(
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
            const Divider(
              height: 1,
              thickness: 1,
              color: Colors.black, // 검정색 선
            ),
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MarkdownEditor(),
                    Comment(),
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
