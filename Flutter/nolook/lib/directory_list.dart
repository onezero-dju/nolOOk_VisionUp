import 'package:flutter/material.dart';
import 'package:nolook/UI/file.dart';

class DirectoryList extends StatelessWidget {
  const DirectoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.create_new_folder,
                size: 45,
                color: Color.fromARGB(255, 90, 174, 207),
              )),
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
