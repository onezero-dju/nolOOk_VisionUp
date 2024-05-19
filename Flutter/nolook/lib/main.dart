import 'package:flutter/material.dart';
import 'package:nolook/screens/memo_screen.dart';

//앱의 시작점
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Markdown Notepad',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MemoScreen(),
    );
  }
}
