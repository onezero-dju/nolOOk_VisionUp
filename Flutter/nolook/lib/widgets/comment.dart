import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  const Comment({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: '댓글',
        hintStyle: TextStyle(color: Colors.black), // 힌트 텍스트 스타일 설정
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black), // 테두리 색상 설정
          borderRadius: BorderRadius.all(Radius.circular(8.0)), // 테두리 라디우스 설정
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black), // 포커스 된 경우 테두리 색상 설정
          borderRadius:
              BorderRadius.all(Radius.circular(8.0)), // 포커스 된 경우 테두리 라디우스 설정
        ),
      ),
    );
  }
}
