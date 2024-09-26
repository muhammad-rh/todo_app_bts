import 'package:flutter/material.dart';

class IconImage extends StatelessWidget {
  const IconImage({
    super.key,
    required this.icon,
    required this.color,
    this.width = 22,
    this.height = 22,
  });

  final String icon;
  final Color color;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 4),
        Image.asset(
          icon,
          color: color,
          width: width,
          height: height,
        ),
        // Icon(Icons.home, size: 22),
        const SizedBox(height: 4),
      ],
    );
  }
}
