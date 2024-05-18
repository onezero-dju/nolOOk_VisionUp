import 'package:flutter/material.dart';

//FileDeleteIcon 아이콘에 대한 클래스
class FileDeleteIcon extends StatelessWidget {
  const FileDeleteIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.delete,
        size: MediaQuery.of(context).size.width * 0.13,
        color: Colors.blue,
      ),
    );
  }
}
