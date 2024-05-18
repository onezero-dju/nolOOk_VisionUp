import 'package:flutter/material.dart';

//Share 아이콘에 대한 클래스
class Share extends StatelessWidget {
  const Share({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.share,
        size: MediaQuery.of(context).size.width * 0.12,
        color: const Color.fromARGB(255, 90, 174, 207),
      ),
    );
  }
}
