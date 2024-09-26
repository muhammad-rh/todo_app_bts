import 'package:flutter/material.dart';
import 'package:todo_app_bts/env/widget/app_text.dart';

class AppIconImage extends StatelessWidget {
  const AppIconImage({
    super.key,
    required this.image,
    required this.label,
    required this.onTap,
    this.color,
    this.width = 36,
    this.height = 36,
  });

  final String image, label;
  final Color? color;
  final double width, height;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            image,
            color: color,
            width: width,
            height: height,
          ),
          // Icon(Icons.home, size: 22),
          const SizedBox(height: 8),
          AppText(
            text: label,
            size: 13,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
