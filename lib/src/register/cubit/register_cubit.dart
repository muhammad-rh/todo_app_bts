import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_bts/env/class/app_env.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  final formKey = GlobalKey<FormState>();

  final cEmail = TextEditingController();
  final cUsername = TextEditingController();
  final cPassword = TextEditingController();
  final cPassconf = TextEditingController();

  Future<void> register({
    required String email,
    required String username,
    required String password,
  }) async {
    emit(RegisterOnLoading());

    try {
      Response response = await AppApi.post(
        path: '/register',
        withToken: false,
        formdata: {
          'email': email,
          'username': username,
          'password': password,
        },
      );

      log('response : $response', name: 'RegisterCubit');

      if (response.statusCode == 200) {
        emit(RegisterOnSuccess());
      } else {
        emit(RegisterOnFailed(message: response.data['message']));
      }
    } catch (e) {
      log('err regist: $e', name: 'RegisterCubit');

      var model = await AppReportModel.onDefault(
        api: [],
        title: 'Gagal Register',
        content: e.toString(),
        type: AppAPIType.post,
      );

      emit(RegisterOnError(model: model));
    }
  }
}
