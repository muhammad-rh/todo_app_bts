import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_bts/env/class/app_env.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final formKey = GlobalKey<FormState>();

  final cUsername = TextEditingController();
  final cPassword = TextEditingController();

  Future<void> login(
      {required String username, required String password}) async {
    emit(LoginOnLoading());

    try {
      Response response = await AppApi.post(
        path: '/login',
        withToken: false,
        formdata: {
          'username': username,
          'password': password,
        },
      );

      log('response : $response', name: 'LoginCubit');

      if (response.statusCode == 200) {
        await AppApi.keepToken(
          token: response.data['data']['token'],
          username: username,
          password: password,
        );

        emit(LoginOnSuccess());
      } else {
        emit(const LoginOnFailed(
            message: 'Maaf, username atau kata sandi salah'));
      }
    } catch (e) {
      log('err : $e', name: 'LoginCubit');
      var model = await AppReportModel.onDefault(
        api: [],
        title: 'Gagal Login',
        content: e.toString(),
        type: AppAPIType.post,
      );

      emit(LoginOnError(model: model));
    }
  }
}
