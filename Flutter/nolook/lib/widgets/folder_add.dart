import 'package:flutter/material.dart';

//FolderAdd 아이콘에 대한 클래스
class FolderAdd extends StatelessWidget {
  const FolderAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.create_new_folder,
        size: MediaQuery.of(context).size.width * 0.13,
        color: Colors.blue,
      ),
    );
  }
}
