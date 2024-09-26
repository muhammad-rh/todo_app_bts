import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_bts/env/extension/on_context.dart';
import 'package:todo_app_bts/env/model/app_date_model.dart';
import 'package:todo_app_bts/env/variable/app_constant.dart';
import 'package:todo_app_bts/src/checklist/cubit/checklist_cubit.dart';
import 'package:todo_app_bts/src/checklist/pages/checlist_detail_page.dart';
import 'package:todo_app_bts/src/homepage/cubit/homepage_cubit.dart';
import 'package:todo_app_bts/src/homepage/models/checklist_model.dart';
import 'package:todo_app_bts/src/homepage/pages/home_page.dart';
import 'package:todo_app_bts/src/login/cubit/login_cubit.dart';
import 'package:todo_app_bts/src/login/pages/login_page.dart';
import 'package:todo_app_bts/src/register/cubit/register_cubit.dart';
import 'package:todo_app_bts/src/register/pages/register_page.dart';

part '../enum/app_enum.dart';
part '../class/app_route.dart';
part '../class/app_parse.dart';
part '../model/app_model.dart';
part '../class/app_api.dart';
part '../class/app_assets.dart';

typedef Env = AppEnvironment;

class AppEnvironment {
  static Map<String, Widget Function(BuildContext)> routes = {
    for (AppRoute route in [
      AppRoute.homePage,
      AppRoute.registerPage,
      AppRoute.loginPage,
      AppRoute.checklistDetailPage,
    ])
      route.path: (BuildContext context) => route.page
  };

  // default
  static String initialRoute = AppRoute.loginPage.path;
  static String dummyRoute = '';

  static AppScope scope = AppScope.external;
}
