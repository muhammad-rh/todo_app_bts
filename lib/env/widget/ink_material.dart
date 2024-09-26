import 'package:flutter/material.dart';
import 'package:todo_app_bts/env/variable/app_constant.dart';

class InkMaterial extends StatelessWidget {
  const InkMaterial(
      {Key? key,
      required this.child,
      this.onTap,
      this.color,
      this.padding,
      this.margin,
      this.splashColor,
      this.highlightColor,
      this.shapeBorder,
      this.tooltip,
      this.borderRadius})
      : super(key: key);
  final Widget child;
  final void Function()? onTap;
  final String? tooltip;
  final Color? color, splashColor, highlightColor;
  final BorderRadius? borderRadius;
  final ShapeBorder? shapeBorder;
  final EdgeInsetsGeometry? padding, margin;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      richMessage: tooltip == null ? const TextSpan() : null,
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Material(
          color: color ?? AppConstant.transparent,
          borderRadius: borderRadius,
          shape: shapeBorder,
          child: InkWell(
            splashColor: splashColor,
            highlightColor: highlightColor ?? AppConstant.transparent,
            onTap: onTap,
            borderRadius: borderRadius,
            customBorder: shapeBorder,
            child: Padding(
              padding: padding ?? EdgeInsets.zero,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
