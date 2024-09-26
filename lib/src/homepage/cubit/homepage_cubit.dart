import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_bts/env/class/app_env.dart';
import 'package:todo_app_bts/src/homepage/models/checklist_model.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'homepage_state.dart';

class HomepageCubit extends Cubit<HomepageState> {
  HomepageCubit() : super(HomepageInitial());

  final formKey = GlobalKey<FormState>();
  final cNameTodo = TextEditingController();

  Future<void> postSaveChecklist() async {
    emit(HomepageOnLoading());

    try {
      Response response = await AppApi.post(
        path: '/checklist',
        formdata: {
          "name": cNameTodo.text,
        },
      );

      log('response : $response', name: 'postSaveChecklist');

      if (response.statusCode == 200) {
        emit(HomepageOnSuccess());
        await getGetAllChecklist();
      } else {
        emit(HomepageOnFailed(
            message: response.data['message'] ?? 'Gagal Save Checklist'));
      }
    } catch (e) {
      log('err : $e', name: 'postSaveChecklist');
      var model = await AppReportModel.onDefault(
        api: [],
        title: 'Gagal Save Checklist',
        content: e.toString(),
        type: AppAPIType.post,
      );

      emit(HomepageOnError(model: model));
    }

    cNameTodo.clear();
  }

  List<ChecklistModel> checklists = [];

  Future<void> getGetAllChecklist() async {
    emit(HomepageOnLoading());

    try {
      Response response = await AppApi.get(
        path: '/checklist',
      );

      log('response : $response', name: 'getGetAllChecklist');

      if (response.statusCode == 200) {
        checklists = (response.data['data'] as List? ?? [])
            .map((e) => ChecklistModel.fromJson(e))
            .toList();

        emit(HomepageOnSuccess());
      } else {
        emit(HomepageOnFailed(
            message: response.data['message'] ?? 'Gagal Get Checklist'));
      }
    } catch (e) {
      log('err : $e', name: 'postChecklistSave');
      var model = await AppReportModel.onDefault(
        api: [],
        title: 'Gagal Get Checklist',
        content: e.toString(),
        type: AppAPIType.get,
      );

      emit(HomepageOnError(model: model));
    }
  }

  Future<void> deleteChecklistById({required int id}) async {
    emit(HomepageOnLoading());

    try {
      Response response = await AppApi.delete(
        path: '/checklist/$id',
      );

      log('response : $response', name: 'deleteChecklistById');

      if (response.statusCode == 200) {
        emit(HomepageOnSuccess());
        await getGetAllChecklist();
      } else {
        emit(HomepageOnFailed(
            message: response.data['message'] ?? 'Gagal Delete ChecklistById'));
      }
    } catch (e) {
      log('err : $e', name: 'deleteChecklistById');
      var model = await AppReportModel.onDefault(
        api: [],
        title: 'Gagal Delete ChecklistById',
        content: e.toString(),
        type: AppAPIType.delete,
      );

      emit(HomepageOnError(model: model));
    }
  }
}
