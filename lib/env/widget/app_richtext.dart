import 'package:flutter/material.dart';

class AppRichText extends StatelessWidget {
  const AppRichText({
    super.key,
    required this.label,
    this.secLabel = ' *',
    this.labelColor = const Color(0xff000000),
    this.secLabelColor = const Color(0xff1A7F09),
    this.isRequired = true,
  });

  final String label, secLabel;
  final Color labelColor, secLabelColor;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: labelColor,
          fontWeight: FontWeight.w600,
        ),
        text: label,
        children: [
          if (isRequired)
            TextSpan(
              text: secLabel,
              style: TextStyle(color: secLabelColor),
            ),
        ],
      ),
    );
  }
}
