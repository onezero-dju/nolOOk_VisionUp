import 'package:flutter/material.dart';
import 'package:nolook/Model/titleEditor.dart';
import 'package:provider/provider.dart';

class TitleEditor extends StatefulWidget {
  const TitleEditor({super.key});

  @override
  _TitleEditorState createState() => _TitleEditorState();

  // controller에 접근할 수 있는 getter 메서드
  TextEditingController? getController(BuildContext context) {
    final TitleEditorModel model = context.read<TitleEditorModel>();
    return model.controller;
  }
}

class _TitleEditorState extends State<TitleEditor> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          child: Consumer<TitleEditorModel>(
            builder: (context, model, _) => GestureDetector(
              child: TextField(
                controller: model.controller,
                decoration: const InputDecoration(
                  hintText: '제목을 입력하세요',
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
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
