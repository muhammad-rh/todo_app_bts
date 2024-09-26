// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:todo_app_bts/env/class/app_env.dart';
import 'package:todo_app_bts/env/class/app_shortcut.dart';
import 'package:todo_app_bts/env/extension/on_context.dart';
import 'package:todo_app_bts/env/variable/app_constant.dart';
import 'package:todo_app_bts/env/variable/variable_shortcut.dart';
import 'package:todo_app_bts/env/widget/app_expired.dart';
import 'package:todo_app_bts/env/widget/app_text.dart';
import 'package:todo_app_bts/env/widget/ink_material.dart';

class BugCatcher extends StatelessWidget {
  const BugCatcher({
    Key? key,
    required this.title,
    required this.content,
    required this.statePath,
    this.button,
    this.icon,
    this.dark = true,
    this.onRefresh,
    required this.pagePath,
    required this.width,
    required this.height,
    this.padding = const EdgeInsets.all(16),
  }) : super(key: key);
  final String title;
  final String content;
  final String statePath;
  final String pagePath;
  final bool dark;
  final Widget? button, icon;
  final double width, height;
  final EdgeInsets padding;
  final void Function()? onRefresh;

  factory BugCatcher.withModel(
    AppReportModel model, {
    void Function()? onRefresh,
    required String statePath,
    required String pagePath,
    required double height,
    required double width,
    EdgeInsets padding = const EdgeInsets.all(16),
  }) =>
      BugCatcher(
        title: model.title,
        content: model.content,
        onRefresh: onRefresh,
        statePath: statePath,
        pagePath: pagePath,
        height: height,
        width: width,
        padding: padding,
      );

  @override
  Widget build(BuildContext context) {
    var my = AppShortcut.of(context);

    return Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        padding: padding,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Stack(alignment: Alignment.center, children: [
            Transform.translate(
              offset: const Offset(0.0, -AppConstant.padding * 3),
              child: AppText(
                text: "‟ $title ”",
                size: 12,
                textColor: my.color.shadow,
                weight: FontWeight.w500,
              ),
            ),
            button ??
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  InkMaterial(
                    color: my.color.onBackground.withOpacity(0.75),
                    splashColor: my.color.error,
                    borderRadius: radiusAll(circular(100.0)),
                    onTap: () => BugSheet(
                            title: title,
                            content: content,
                            pagePath: pagePath,
                            statePath: statePath)
                        .openWith(context),
                    child: Container(
                      height: AppConstant.buttonHeight,
                      alignment: Alignment.center,
                      padding: insetAxis(x: AppConstant.padding),
                      child: const AppText(
                        text: 'Baca Selengkapnya',
                        weight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (onRefresh != null)
                    InkMaterial(
                      onTap: onRefresh,
                      margin: insetOn(left: AppConstant.padding / 2),
                      color: my.color.onBackground.withOpacity(0.75),
                      splashColor: my.color.error,
                      shapeBorder: const CircleBorder(),
                      child: SizedBox(
                        width: AppConstant.buttonHeight,
                        height: AppConstant.buttonHeight,
                        child: Icon(
                          Icons.refresh_outlined,
                          color: my.color.shadow,
                        ),
                      ),
                    )
                ])
          ])
        ]));
  }
}

class BugSheet extends StatelessWidget {
  const BugSheet(
      {Key? key,
      required this.title,
      required this.content,
      required this.pagePath,
      required this.statePath})
      : super(key: key);
  final String title, content, pagePath, statePath;

  factory BugSheet.withModel(AppReportModel model,
          {required String pagePath, required String statePath}) =>
      BugSheet(
          title: model.title,
          content: model.content,
          pagePath: pagePath,
          statePath: statePath);

  @override
  Widget build(BuildContext context) {
    var my = AppShortcut.of(context);

    return Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(maxHeight: my.query.size.height / 2.5),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
              constraints: const BoxConstraints(minHeight: kToolbarHeight),
              color: my.color.error,
              padding: insetAxis(x: AppConstant.padding),
              child: Row(children: [
                Expanded(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(title,
                          style: my.text.labelMedium
                              ?.copyWith(fontSize: 14, color: Colors.white),
                          textAlign: TextAlign.start),
                      FutureBuilder(
                          future: PackageInfo.fromPlatform(),
                          builder: (_, AsyncSnapshot<PackageInfo> snap) {
                            if (snap.connectionState == ConnectionState.done &&
                                snap.data != null) {
                              return Text(
                                  "${AppAsset.appLabel} v${snap.data?.version ?? 0.0}",
                                  textAlign: TextAlign.end,
                                  style: my.text.labelSmall?.copyWith(
                                      color: Colors.white.withOpacity(0.75),
                                      fontSize: 10));
                            } else {
                              return const SizedBox();
                            }
                          })
                    ])),
                InkMaterial(
                    tooltip: "Salin Rincian Masalah",
                    shapeBorder: const CircleBorder(),
                    onTap: () async {
                      PackageInfo package = await PackageInfo.fromPlatform();
                      String message =
                          'TITLE: $title\nDATE: ${DateTime.now()}\nSTATE PATH: $statePath\nPAGE PATH: $pagePath\nCONTENT: $content\nVERSION: ${package.version}';
                      await Clipboard.setData(ClipboardData(text: message));
                      context.close();
                      context.alert(
                          label: "Rincian Masalah Berhasil Disalin",
                          color: my.color.secondary);
                    },
                    child: Padding(
                        padding: insetAll(AppConstant.radius),
                        child: const Icon(Icons.copy,
                            size: 20, color: Colors.white)))
              ])),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: Colors.white),
              child: Scrollbar(
                child: SingleChildScrollView(
                  padding: insetAll(AppConstant.padding),
                  child: AppText(
                    text: content,
                    textColor: my.color.shadow,
                    maxLines: 5,
                    weight: FontWeight.w500,
                    textAlign: TextAlign.left,
                    size: 11,
                  ),
                ),
              ),
            ),
          ),
        ]));
  }

  Future<T?> openWith<T extends Object?>(BuildContext context) {
    if (content.contains('Http status error [403]')) {
      return context.to(child: const AppExpired());
    } else {
      return showModalBottomSheet<T>(
          backgroundColor: AppConstant.transparent,
          barrierColor:
              Theme.of(context).colorScheme.onBackground.withOpacity(0.55),
          context: context,
          builder: (_) => BugSheet(
              title: title,
              content: content,
              pagePath: pagePath,
              statePath: statePath));
    }
  }
}
