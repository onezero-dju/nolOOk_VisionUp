import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

//FolderAdd 아이콘에 대한 클래스
class FolderAdd extends StatelessWidget {
  const FolderAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.17,
      height: MediaQuery.of(context).size.height * 0.17,
      child: SvgPicture.asset(
        'assets/images/FolderAdd.svg',
      ),
    );
  }
}
