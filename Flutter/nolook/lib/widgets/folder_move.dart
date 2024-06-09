import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nolook/View/directory_list.dart';

//FolderMove 아이콘에 대한 클래스
class FolderMove extends StatelessWidget {
  const FolderMove({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DirectoryList()));
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.17,
        height: MediaQuery.of(context).size.width * 0.17,
        child: SvgPicture.asset(
          'assets/images/Directory.svg',
        ),
      ),
    );
  }
}
