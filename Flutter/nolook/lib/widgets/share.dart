import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//Share 아이콘에 대한 클래스
class Share extends StatelessWidget {
  const Share({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SvgPicture.asset(
        'assets/images/Share.svg',
        width: 100,
        height: 100,
      ),
    );
  }
}
