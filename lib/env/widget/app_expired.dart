// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:todo_app_bts/env/class/app_env.dart';
import 'package:todo_app_bts/env/class/app_shortcut.dart';
import 'package:todo_app_bts/env/extension/on_context.dart';
import 'package:todo_app_bts/env/variable/app_constant.dart';
import 'package:todo_app_bts/env/variable/variable_shortcut.dart';
import 'package:todo_app_bts/env/widget/app_button.dart';

class AppExpired extends StatelessWidget {
  const AppExpired({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var my = AppShortcut.of(context);
    return PopScope(
      onPopInvoked: (didPop) => false,
      child: Scaffold(
        backgroundColor: my.color.background,
        body: SafeArea(
            child: Padding(
                padding: insetAll(AppConstant.padding),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Lottie.asset('assets/animation/locked.json',
                      //     repeat: false),
                      Text("\nSesi Berakhir\n",
                          style: my.text.labelMedium?.copyWith(
                              color: my.color.primary.withOpacity(0.75),
                              height: 0.5,
                              fontSize: 30)),
                      Text(
                          "Sepertinya akunmu sedang dibuka diperangkat lain saat ini\n",
                          style: my.text.labelSmall?.copyWith(
                              color: my.color.primary.withOpacity(0.5)),
                          textAlign: TextAlign.center),
                    ]))),
        bottomNavigationBar: AppButton(
          label: 'Logout',
          onTap: () async {
            await AppApi.removeToken(context);
            context.removeToNamed(route: Env.initialRoute);
          },
        ),
        // CustomTextButton(
        //   text: "LOGOUT",
        //   onTap: () async {
        //     await LJRApi.removeToken();
        //     context.removeToNamed(route: Env.initialRoute);
        //   },
        //   textStyle: my.text.labelMedium
        //       ?.copyWith(color: my.color.background, fontSize: 14),
        //   color: my.color.primary,
        //   margin: inset(padding, 0, padding, padding),
        // )
      ),
    );
  }
}
