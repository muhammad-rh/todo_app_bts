import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app_bts/env/class/app_shortcut.dart';
import 'package:todo_app_bts/env/variable/app_constant.dart';
import 'package:todo_app_bts/env/widget/app_text.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.textController,
    required this.validator,
    this.labelSize = 12,
    this.isPassword = false,
    this.withIcon = true,
    this.isEnabled,
    this.isDisabled,
    this.icon,
    this.prefixText,
    this.inputFormatters,
    this.keyboardType,
    this.suffixIcon,
    this.onChanged,
    this.topWidget,
    this.colorLabel,
    this.minLines,
    this.maxLines = 1,
  });

  final String label, hint;
  final double labelSize;
  final TextEditingController textController;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final bool isPassword, withIcon;
  final bool? isEnabled, isDisabled;
  final String? icon, prefixText;
  final Widget? suffixIcon, topWidget;
  final Color? colorLabel;
  final int? minLines, maxLines;
  final Function(String)? onChanged;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    var my = AppShortcut.of(context);
    if (widget.isPassword == true) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: widget.label,
                size: widget.labelSize,
                weight: FontWeight.w600,
                textColor: widget.colorLabel ?? Colors.black,
              ),
              widget.topWidget ?? const SizedBox(),
            ],
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: widget.textController,
            validator: widget.validator,
            obscureText: !passwordVisible,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            inputFormatters: widget.inputFormatters,
            keyboardType: widget.keyboardType,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              hintText: widget.hint,
              errorMaxLines: 99,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
                splashRadius: 1,
                icon: passwordVisible
                    ? Icon(
                        Icons.visibility,
                        color: my.color.primary,
                      )
                    : const Icon(Icons.visibility_off, color: AppConstant.grey),
              ),
              contentPadding: const EdgeInsets.all(10),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: My.grey4),
                borderRadius: BorderRadius.circular(5.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: My.grey4),
                borderRadius: BorderRadius.circular(5.0),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: My.grey4),
                borderRadius: BorderRadius.circular(5.0),
              ),
              hintStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                // fontStyle: FontStyle.italic,
              ),
              errorStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.error,
              ),
              isDense: true,
              filled: true,
              fillColor: My.grey3,
            ),
          ),
          const SizedBox(height: 8),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              text: widget.label,
              size: widget.labelSize,
              textColor: widget.colorLabel ?? Colors.black,
              weight: FontWeight.w600,
            ),
            widget.topWidget ?? const SizedBox(),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.textController,
          validator: widget.validator,
          enabled: widget.isEnabled,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: (widget.isDisabled ?? false) ? My.grey : AppConstant.black,
          ),
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: widget.hint,
            errorMaxLines: 99,
            suffixIcon: widget.suffixIcon,
            contentPadding: const EdgeInsets.all(10),
            hintStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              // fontStyle: FontStyle.italic,
            ),
            errorStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.error,
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 0.7,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: My.grey4),
              borderRadius: BorderRadius.circular(5.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: My.grey4),
              borderRadius: BorderRadius.circular(5.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: My.grey4),
              borderRadius: BorderRadius.circular(5.0),
            ),
            isDense: true,
            filled: true,
            fillColor: My.grey3,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
