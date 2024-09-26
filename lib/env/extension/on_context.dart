import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app_bts/env/class/app_shortcut.dart';
import 'package:todo_app_bts/env/variable/app_constant.dart';
import 'package:todo_app_bts/env/variable/variable_shortcut.dart';
import 'package:todo_app_bts/env/widget/bug_catcher.dart';

extension OnContext on BuildContext {
  T? modal<T extends Object?>() =>
      ModalRoute.of(this)?.settings.arguments as T?;

  Future<T?> toNamed<T extends Object?>(
      {required String route, Object? arguments}) {
    try {
      return Navigator.pushNamed<T>(this, route, arguments: arguments);
    } catch (e) {
      throw BugSheet(
              title: "Gagal Membuka Rute $route",
              content: "$e",
              pagePath: "env/extension/app_context.dart",
              statePath: "-")
          .openWith(this);
    }
  }

  Future<T?> toReplacementNamed<T extends Object?, TO>(
      {required String route, Object? arguments, TO? result}) {
    try {
      return Navigator.pushReplacementNamed(this, route, arguments: arguments);
    } catch (e) {
      throw BugSheet(
              title: "Gagal Membuka Rute $route",
              content: "$e",
              pagePath: "env/extension/app_context.dart",
              statePath: "-")
          .openWith(this);
    }
  }

  Future<T?> to<T extends Object?>({required Widget child, Object? arguments}) {
    try {
      return Navigator.push<T>(this, MaterialPageRoute(builder: (_) => child));
    } catch (e) {
      throw BugSheet(
              title: "Gagal Membuka Halaman",
              content: "$e",
              pagePath: "env/extension/app_context.dart",
              statePath: "-")
          .openWith(this);
    }
  }

  static Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
      BuildContext context, Route<T> newRoute,
      {TO? result}) {
    return Navigator.of(context)
        .pushReplacement<T, TO>(newRoute, result: result);
  }

  Future<T?> toReplacement<T extends Object?, TO extends Object?>(
      {TO? result, required Widget child}) {
    try {
      return Navigator.pushReplacement(
        this,
        MaterialPageRoute(builder: (_) => child),
      );
    } catch (e) {
      throw BugSheet(
              title: "Gagal Membuka Halaman",
              content: "$e",
              pagePath: "env/extension/app_context.dart",
              statePath: "-")
          .openWith(this);
    }
  }

  Future<T?> removeToNamed<T extends Object?>(
      {required String route, Object? arguments}) {
    try {
      return Navigator.pushNamedAndRemoveUntil(this, route, (route) => false,
          arguments: arguments);
    } catch (e) {
      throw BugSheet(
              title: "Gagal Pindah ke Rute $route",
              content: "$e",
              pagePath: "env/extension/app_context.dart",
              statePath: "-")
          .openWith(this);
    }
  }

  void close<T extends Object?>([T? result]) => Navigator.pop<T>(this, result);

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> alert(
      {required String label,
      Color? color,
      Duration? duration,
      EdgeInsetsGeometry? margin,
      void Function(ScaffoldMessengerState snackbar)? onTap}) {
    var my = AppShortcut.of(this);
    return ScaffoldMessenger.of(this).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(circular(AppConstant.radius))),
        margin: margin ?? insetOn(left: 20, bottom: 20, right: 20),
        elevation: 2,
        content: GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(this).hideCurrentSnackBar();
          },
          child: Row(children: [
            const Icon(Icons.info_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
                child: Text(label.toUpperCase(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 10.0)))
          ]),
        ),
        backgroundColor: color ?? my.color.error.withOpacity(0.925),
        duration: duration ?? AppConstant.alertDuration));
  }

  Future<T?> show<T extends Object?>(
          {required Widget child, bool dismissible = true, Timer? timer}) =>
      showDialog<T>(
        context: this,
        barrierDismissible: dismissible,
        builder: (_) => child,
      ).then(
        (value) {
          if (timer != null && timer.isActive) {
            timer.cancel();
          }
          return value;
        },
      );

  Future<T?> sheet<T extends Object?>(
          {required Widget child,
          double vertRadius = 8,
          bool isScrollable = false,
          bool isDismissible = true,
          double maxWidth = double.infinity}) =>
      showModalBottomSheet(
          context: this,
          isDismissible: isDismissible,
          builder: (ctx) => child,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(vertRadius),
            ),
          ),
          constraints: BoxConstraints(
            maxWidth: maxWidth,
          ),
          isScrollControlled: isScrollable,
          backgroundColor:
              isScrollable == true ? AppConstant.transparent : Colors.white);

  Future<T?> clearTo<T extends Object?>({required Widget child}) =>
      Navigator.pushAndRemoveUntil<T>(
          this, MaterialPageRoute(builder: (_) => child), (route) => false);
}
