import 'package:flutter/material.dart';

class FileAdd extends StatelessWidget {
  const FileAdd({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.note_add_outlined,
        size: MediaQuery.of(context).size.width * 0.12,
        color: const Color.fromARGB(255, 90, 174, 207),
      ),
    );
  }
}
