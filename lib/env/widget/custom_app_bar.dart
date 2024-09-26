import 'package:flutter/material.dart';
import 'package:todo_app_bts/env/class/app_shortcut.dart';
import 'package:todo_app_bts/env/extension/on_context.dart';
import 'package:todo_app_bts/env/variable/app_constant.dart';
import 'package:todo_app_bts/env/widget/app_text.dart';
import 'package:todo_app_bts/env/widget/ink_material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    Key? key,
    required this.label,
    PreferredSizeWidget? bottom,
    this.onClose,
    this.isBack = true,
  }) : super(key: key, bottom: bottom);
  final String label;
  final Function()? onClose;
  final bool isBack;

  @override
  bool get automaticallyImplyLeading => false;

  @override
  Color? get backgroundColor => My.transparent;

  @override
  double? get elevation => 5;

  @override
  Widget? get flexibleSpace => Builder(
        builder: (context) {
          var my = AppShortcut.of(context);

          return Container(
            padding: const EdgeInsets.only(top: 24),
            height: kToolbarHeight * 2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1A7F09), Color(0xFF82CD47)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (isBack)
                  Positioned(
                    left: 0,
                    bottom: -1,
                    child: InkMaterial(
                      onTap: onClose ?? () => context.close(),
                      splashColor: my.color.background.withOpacity(0.1),
                      padding: const EdgeInsets.all(My.padding * 1.25),
                      shapeBorder: const CircleBorder(),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                AppText(
                  text: label,
                  textAlign: TextAlign.center,
                  size: 16,
                  weight: FontWeight.w500,
                  textColor: Colors.white,
                ),
              ],
            ),
          );
        },
      );
}
