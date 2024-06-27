import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//Share 아이콘에 대한 클래스
class Share extends StatelessWidget {
  const Share({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.17,
      height: MediaQuery.of(context).size.width * 0.3,
      child: SvgPicture.asset(
        'assets/images/Share.svg',
      ),
    );
  }
}
