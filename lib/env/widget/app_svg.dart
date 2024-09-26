import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSvg extends StatelessWidget {
  const AppSvg({
    super.key,
    required this.svg,
    this.size,
  });

  final String svg;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      child: SvgPicture.asset(
        svg,
        width: size,
        height: size,
      ),
    );
  }
}
