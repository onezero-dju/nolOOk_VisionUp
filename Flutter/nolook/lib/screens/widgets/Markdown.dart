import 'package:flutter/material.dart';

class MarkdownEditor extends StatefulWidget {
  const MarkdownEditor({super.key});

  @override
  _MarkdownEditorState createState() => _MarkdownEditorState();
}

class _MarkdownEditorState extends State<MarkdownEditor> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 투명한 TextField
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: TextField(
            controller: _controller,
            maxLines: null,
            decoration: const InputDecoration(
              hintText: '메모를 입력하세요',
              border: InputBorder.none,
            ),
            style: const TextStyle(color: Colors.black),
            cursorColor: Colors.black,
            onChanged: (text) {},
          ),
        ),
      ],
    );
  }
}
