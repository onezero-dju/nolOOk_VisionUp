import 'package:flutter/material.dart';

class Check extends StatelessWidget {
  const Check({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.check,
        size: MediaQuery.of(context).size.width * 0.12,
        color: const Color.fromARGB(255, 90, 174, 207),
      ),
    );
  }
}
