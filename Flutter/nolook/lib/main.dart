import 'package:flutter/material.dart';
import 'package:nolook/Controller/directory_controller.dart';
import 'package:nolook/Model/contentEdItor.dart';
import 'package:nolook/Model/titleEditor.dart';
import 'package:nolook/providers/directory_provider.dart';
import 'package:nolook/providers/file_selection_provider.dart';
import 'package:nolook/providers/selected_directory_provider.dart';

import 'package:provider/provider.dart';
import 'package:nolook/view/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TitleEditorModel()), // 새로 추가
        ChangeNotifierProvider(create: (_) => ContentEditorModel()),
        // ChangeNotifierProvider(create: (_) => DirectoryProvider()),
        ChangeNotifierProvider(create: (_) => FileSelectionController()),
        ChangeNotifierProvider(create: (_) => SelectedDirectoryProvider()),
        ChangeNotifierProvider(create: (_) => DirectoryController()),
      ],
      child: const nolOOk(),
    ),
  );
}

class nolOOk extends StatelessWidget {
  const nolOOk({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'nolOOk',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
