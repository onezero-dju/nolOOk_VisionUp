import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

//FolderAdd 아이콘에 대한 클래스
class FolderAdd extends StatelessWidget {
  const FolderAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SvgPicture.asset(
        'assets/images/FolderAdd.svg',
        width: 100,
        height: 100,
      ),
    );
  }
}
