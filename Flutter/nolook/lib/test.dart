import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MarkdownTextField(),
    );
  }
}

class MarkdownTextField extends StatefulWidget {
  const MarkdownTextField({super.key});

  @override
  _MarkdownTextFieldState createState() => _MarkdownTextFieldState();
}

class _MarkdownTextFieldState extends State<MarkdownTextField> {
  final TextEditingController _controller = TextEditingController();
  String _markdownText = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _markdownText = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Markdown TextField'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            TextField(
              controller: _controller,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Enter your markdown text here',
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                color: Colors.transparent, // 텍스트 색상을 투명하게 설정
                backgroundColor: Color.fromARGB(0, 100, 41, 41),
              ),
              cursorColor: Colors.black,
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: Markdown(
                  data: _markdownText,
                  styleSheet: MarkdownStyleSheet(
                    p: const TextStyle(color: Colors.black), // 텍스트 색상 설정
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
