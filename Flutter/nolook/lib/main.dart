import 'package:flutter/material.dart';
import 'package:nolook/screens/login_screen.dart';

//앱의 시작점
void main() {
  runApp(const nolOOk());
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
