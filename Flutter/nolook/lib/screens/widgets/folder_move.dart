import 'package:flutter/material.dart';
import 'package:nolook/screens/directory_list.dart';

//FolderMove 아이콘에 대한 클래스
class FolderMove extends StatelessWidget {
  const FolderMove({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DirectoryList()));
      },
      icon: Icon(
        Icons.folder_copy,
        size: MediaQuery.of(context).size.width * 0.13,
        color: Colors.blue,
      ),
    );
  }
}
