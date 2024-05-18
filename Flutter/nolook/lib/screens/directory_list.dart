import 'package:flutter/material.dart';
import 'package:nolook/screens/widgets/check.dart';
import 'package:nolook/screens/widgets/file.dart';
import 'package:nolook/screens/widgets/file_add.dart';
import 'package:nolook/screens/widgets/folder_add.dart';
import 'package:nolook/screens/widgets/share.dart';

class DirectoryList extends StatelessWidget {
  const DirectoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: const FolderAdd(),
          actions: const [
            Row(
              children: [
                FileAdd(),
                Share(),
                Check(),
              ],
            ),
          ],
        ),
        body: const Row(
          children: [
            File(),
            File(),
            File(),
          ],
        ),
      ),
    );
  }
}
