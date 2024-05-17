import 'package:flutter/material.dart';

class File extends StatelessWidget {
  const File({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.folder,
        size: MediaQuery.of(context).size.width * 0.29,
        color: Colors.blue,
      ),
    );
  }
}
