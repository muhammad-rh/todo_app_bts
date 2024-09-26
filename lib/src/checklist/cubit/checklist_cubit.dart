import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_bts/env/class/app_env.dart';
import 'package:todo_app_bts/src/checklist/models/item_model.dart';

part 'checklist_state.dart';

class ChecklistCubit extends Cubit<ChecklistState> {
  ChecklistCubit() : super(ChecklistInitial());

  final formKey = GlobalKey<FormState>();
  final cItemName = TextEditingController();

  Future<void> postSaveChecklistItem({required int idChecklist}) async {
    emit(ChecklistOnLoading());

    try {
      Response response = await AppApi.post(
        path: '/checklist/$idChecklist/item',
        formdata: {
          "itemName": cItemName.text,
        },
      );

      log('response : $response', name: 'postSaveChecklistItem');

      if (response.statusCode == 200) {
        await getFindAllChecklistItem(idChecklist: idChecklist);
        emit(ChecklistOnSuccess());
      } else {
        emit(ChecklistOnFailed(
            message: response.data['message'] ?? 'Gagal SaveChecklistItem'));
      }
    } catch (e) {
      log('err : $e', name: 'postSaveChecklistItem');
      var model = await AppReportModel.onDefault(
        api: [],
        title: 'Gagal SaveChecklistItem',
        content: e.toString(),
        type: AppAPIType.post,
      );

      emit(ChecklistOnError(model: model));
    }

    cItemName.clear();
  }

  List<ItemModel> items = [];

  Future<void> getFindAllChecklistItem({required int idChecklist}) async {
    emit(ChecklistOnLoading());

    try {
      Response response = await AppApi.get(
        path: '/checklist/$idChecklist/item',
      );

      log('response : $response', name: 'getFindAllChecklistItem');

      if (response.statusCode == 200) {
        items = (response.data['data'] as List? ?? [])
            .map((e) => ItemModel.fromJson(e))
            .toList();

        emit(ChecklistOnSuccess());
      } else {
        emit(ChecklistOnFailed(
            message:
                response.data['message'] ?? 'Gagal Get FindAllChecklistItem'));
      }
    } catch (e) {
      log('err : $e', name: 'postChecklistSave');
      var model = await AppReportModel.onDefault(
        api: [],
        title: 'Gagal Get FindAllChecklistItem',
        content: e.toString(),
        type: AppAPIType.get,
      );

      emit(ChecklistOnError(model: model));
    }
  }

  Future<void> putUpdateItemStatus(
      {required int idChecklist, required int idItem}) async {
    emit(ChecklistOnLoading());

    try {
      Response response = await AppApi.put(
        path: '/checklist/$idChecklist/item/$idItem',
      );

      log('response : $response', name: 'putUpdateItemStatus');

      if (response.statusCode == 200) {
        emit(ChecklistOnSuccess());
        await getFindAllChecklistItem(idChecklist: idChecklist);
      } else {
        emit(ChecklistOnFailed(
            message: response.data['message'] ?? 'Gagal Put UpdateItemStatus'));
      }
    } catch (e) {
      log('err : $e', name: 'putUpdateItemStatus');
      var model = await AppReportModel.onDefault(
        api: [],
        title: 'Gagal Put UpdateItemStatus',
        content: e.toString(),
        type: AppAPIType.put,
      );

      emit(ChecklistOnError(model: model));
    }
  }

  Future<void> deleteItem(
      {required int idChecklist, required int idItem}) async {
    emit(ChecklistOnLoading());

    try {
      Response response = await AppApi.delete(
        path: '/checklist/$idChecklist/item/$idItem',
      );

      log('response : $response', name: 'deleteItem');

      if (response.statusCode == 200) {
        emit(ChecklistOnSuccess());
        await getFindAllChecklistItem(idChecklist: idChecklist);
      } else {
        emit(ChecklistOnFailed(
            message: response.data['message'] ?? 'Gagal Delete Item'));
      }
    } catch (e) {
      log('err : $e', name: 'deleteItem');
      var model = await AppReportModel.onDefault(
        api: [],
        title: 'Gagal Delete Item',
        content: e.toString(),
        type: AppAPIType.delete,
      );

      emit(ChecklistOnError(model: model));
    }
  }

  void editItem({required int index}) {
    emit(ChecklistInitial());
    cItemName.text = items[index].name;
    emit(ChecklistOnSuccess());
  }

  Future<void> putRenameItem(
      {required int idChecklist, required int idItem}) async {
    emit(ChecklistOnLoading());

    try {
      Response response = await AppApi.put(
        path: '/checklist/$idChecklist/item/rename/$idItem',
        formdata: {
          "itemName": cItemName.text,
        },
      );

      log('response : $response', name: 'putRenameItem');

      if (response.statusCode == 200) {
        await getFindAllChecklistItem(idChecklist: idChecklist);
        emit(ChecklistOnSuccess());
      } else {
        emit(ChecklistOnFailed(
            message: response.data['message'] ?? 'Gagal Put Rename Item'));
      }
    } catch (e) {
      log('err : $e', name: 'putRenameItem');
      var model = await AppReportModel.onDefault(
        api: [],
        title: 'Gagal Put RenameItem',
        content: e.toString(),
        type: AppAPIType.put,
      );

      emit(ChecklistOnError(model: model));
    }

    cItemName.clear();
  }
}
