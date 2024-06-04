// 상태를 관리할 모델 클래스
import 'package:flutter/material.dart';

class MarkdownEditorModel extends ChangeNotifier {
  String _text = '';

  String get text => _text;

  set text(String newText) {
    _text = newText;
    notifyListeners(); // 변경 사항을 리스너에 통지
  }
}
