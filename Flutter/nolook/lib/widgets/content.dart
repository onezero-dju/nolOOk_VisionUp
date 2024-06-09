import 'package:flutter/material.dart';
import 'package:nolook/Model/contentEdItor.dart';
import 'package:provider/provider.dart';

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  _ContentEditorState createState() => _ContentEditorState();

  // controller에 접근할 수 있는 getter 메서드
  TextEditingController? getController(BuildContext context) {
    final ContentEditorModel model = context.read<ContentEditorModel>();
    return model.controller;
  }
}

class _ContentEditorState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Consumer<ContentEditorModel>(
            builder: (context, model, _) => GestureDetector(
              child: TextField(
                controller: model.controller,
                decoration: const InputDecoration(
                  hintText: '내용을 입력하세요',
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                cursorColor: Colors.black,
                onChanged: (text) {
                  model.text = text;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
