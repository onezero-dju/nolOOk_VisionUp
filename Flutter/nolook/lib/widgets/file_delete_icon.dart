import 'package:flutter/material.dart';
import 'package:nolook/Controller/directory_controller.dart';

//FileDeleteIcon 아이콘에 대한 클래스
class FileDeleteIcon extends StatelessWidget {
  FileDeleteIcon({super.key});
  final DirectoryController _directoryController = DirectoryController();

  Future<void> deleteDirectory() async {
    try {
      // await _directoryController.deleteDirectory(); 선택돼있는 directory의 id를 넣어줘야 한다
    } catch (error) {
      print('Error: $error');
    }
  }

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
