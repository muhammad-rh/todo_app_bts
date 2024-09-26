import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radius = 8,
    this.spread = 1,
    this.blur = 4,
    this.margin,
    this.offset = const Offset(0, 4),
    this.onTap,
    this.backgroundColor = const Color(0xFFFFFFFF),
  });

  final Widget child;
  final double radius, spread, blur;
  final Offset offset;
  final EdgeInsets? margin, padding;
  final Function()? onTap;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.05),
            spreadRadius: spread,
            blurRadius: blur,
            offset: offset,
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );
  }
}
