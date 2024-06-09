import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FileAdd extends StatelessWidget {
  const FileAdd({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.13,
      height: MediaQuery.of(context).size.height * 0.1,
      child: SvgPicture.asset(
        'assets/images/FileAdd.svg',
      ),
    );
  }
}
