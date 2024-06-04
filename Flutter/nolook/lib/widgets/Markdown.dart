import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nolook/Model/MarkdownEditor.dart';

class MarkdownEditor extends StatefulWidget {
  const MarkdownEditor({super.key});

  @override
  _MarkdownEditorState createState() => _MarkdownEditorState();

  // controller에 접근할 수 있는 getter 메서드
  TextEditingController? getController(BuildContext context) {
    final model = context.read<MarkdownEditorModel>();
    return model.controller;
  }
}

class _MarkdownEditorState extends State<MarkdownEditor> {
  late MarkdownEditorModel _model; // 모델 인스턴스

  @override
  void initState() {
    super.initState();
    _model = MarkdownEditorModel(); // 모델 초기화
  }

  @override
  void dispose() {
    _model.dispose(); // 모델 dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _model, // Provider를 통해 모델을 전달
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Consumer<MarkdownEditorModel>(
              builder: (context, model, _) => TextField(
                controller: model.controller, // 컨트롤러 사용
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: '메모를 입력하세요',
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                onChanged: (text) {
                  model.text = text; // 텍스트 변경 시 모델 업데이트
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
