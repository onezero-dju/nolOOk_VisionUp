import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Check extends StatelessWidget {
  const Check({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.17,
      height: MediaQuery.of(context).size.height * 0.17,
      child: SvgPicture.asset(
        'assets/images/Check.svg',
      ),
    );
  }
}
