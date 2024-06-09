import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FileAdd extends StatelessWidget {
  const FileAdd({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/FileAdd.svg',
      width: 100,
      height: 100,
    );
  }
}
