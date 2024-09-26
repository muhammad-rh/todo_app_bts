import 'package:flutter/material.dart';
import 'package:todo_app_bts/env/class/app_shortcut.dart';
import 'package:todo_app_bts/env/variable/app_constant.dart';
import 'package:todo_app_bts/env/widget/app_text.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.textColor = const Color(0xFFFFFFFF),
    this.backgroundColor = const Color(0xFF1A7F09),
    this.borderColor = AppConstant.transparent,
    required this.onTap,
    this.padding = 14,
    this.radius = 5,
    this.elevation = 4,
    this.left = 0,
    this.top = 0,
    this.right = 0,
    this.bottom = 0,
    // this.gradient,
  });

  final String label;
  final Color textColor, backgroundColor, borderColor;
  final Function() onTap;
  final double padding, radius, elevation, left, top, right, bottom;
  // Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: Row(
        children: [
          Expanded(
            child: Material(
              elevation: elevation,
              color: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
                side: BorderSide(
                  color: borderColor,
                  width: 1,
                ),
              ),
              child: InkWell(
                onTap: onTap,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: padding),
                  child: AppText(
                    text: label,
                    textColor: textColor,
                    textAlign: TextAlign.center,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget secondary({
    required String label,
    required Function() onTap,
    Color textColor = const Color(0xFF1A7F09),
    Color backgroundColor = const Color(0xFFFFFFFF),
    double padding = 14,
    double radius = 5,
    double elevation = 4,
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      AppButton(
        label: label,
        onTap: onTap,
        textColor: textColor,
        backgroundColor: backgroundColor,
        borderColor: textColor,
        padding: padding,
        radius: radius,
        elevation: elevation,
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      );

  static Widget tertiary({
    required String label,
    required Function() onTap,
    Color textColor = const Color(0xFF1A7F09),
    Color backgroundColor = const Color(0xFF1A7F09),
    double padding = 14,
    double radius = 5,
    double elevation = 0,
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      AppButton(
        label: label,
        onTap: onTap,
        textColor: textColor,
        backgroundColor: backgroundColor.withOpacity(0.1),
        borderColor: backgroundColor.withOpacity(0.1),
        padding: padding,
        radius: radius,
        elevation: elevation,
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      );

  static Widget inActive({
    required String label,
    Color textColor = const Color(0xFF747474),
    Color backgroundColor = const Color(0xFF919191),
    double padding = 14,
    double radius = 5,
    double elevation = 0,
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      AppButton(
        label: label,
        onTap: () {},
        textColor: textColor,
        backgroundColor: backgroundColor.withOpacity(0.4),
        borderColor: backgroundColor,
        padding: padding,
        radius: radius,
        elevation: elevation,
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      );
}

class AppButtonloading extends StatelessWidget {
  const AppButtonloading({
    super.key,
    this.height = 48,
    this.left = 0,
    this.top = 0,
    this.right = 0,
    this.bottom = 0,
  });

  final double height, left, top, right, bottom;

  @override
  Widget build(BuildContext context) {
    var my = AppShortcut.of(context);

    return Container(
      height: height,
      width: my.query.size.width,
      margin: EdgeInsets.fromLTRB(left, top, right, bottom),
      decoration: BoxDecoration(
        color: my.color.onBackground.withOpacity(0.4),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: my.color.outline),
      ),
      child: Center(
        child: Transform.scale(
          scale: 0.75,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
