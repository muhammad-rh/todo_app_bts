import 'package:flutter/material.dart';
import 'package:todo_app_bts/env/class/app_shortcut.dart';
import 'package:todo_app_bts/env/extension/on_context.dart';
import 'package:todo_app_bts/env/variable/app_constant.dart';
import 'package:todo_app_bts/env/widget/app_button.dart';
import 'package:todo_app_bts/env/widget/app_text.dart';
import 'package:todo_app_bts/env/widget/app_textfield.dart';
import 'package:todo_app_bts/env/widget/custom_app_bar.dart';
import 'package:todo_app_bts/src/checklist/cubit/checklist_cubit.dart';
import 'package:todo_app_bts/src/homepage/cubit/homepage_cubit.dart';
import 'package:todo_app_bts/src/homepage/models/checklist_model.dart';

class ChecklistDetailPage extends StatelessWidget {
  const ChecklistDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    var my = AppShortcut.of(context);
    var modal = context.modal<Map<String, dynamic>?>();
    var cubit = context.watch<ChecklistCubit>();

    ChecklistModel checklist = modal!['data'];

    return BlocListener<ChecklistCubit, ChecklistState>(
      listener: (_, state) {
        if (state is ChecklistOnFailed) {
          context.alert(label: state.message, color: my.color.secondary);
        }

        if (state is ChecklistOnError) {
          context.alert(label: state.model.title, color: my.color.error);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(label: 'Checklist Detail'),
        body: _buildBody(context, cubit, checklist),
        floatingActionButton: _fabButton(context, cubit, checklist),
      ),
    );
  }

  Widget _buildBody(
      BuildContext context, ChecklistCubit cubit, ChecklistModel checklist) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        InkWell(
          onTap: () => cubit.getFindAllChecklistItem(idChecklist: checklist.id),
          child: AppText(
            text: checklist.name,
            size: 18,
            weight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        cubit.items.isEmpty
            ? const Center(
                child: AppText(
                  text: 'Tambahkan Item',
                  textColor: Colors.black,
                ),
              )
            : Column(
                children: List.generate(
                  cubit.items.length,
                  (x) => Row(
                    children: [
                      InkWell(
                        onTap: () => cubit.putUpdateItemStatus(
                          idChecklist: checklist.id,
                          idItem: cubit.items[x].id,
                        ),
                        child: Icon(
                          cubit.items[x].itemCompletionStatus
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: My.green2,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: AppText(text: cubit.items[x].name),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () async {
                          cubit.editItem(index: x);
                          context.show(
                            child: AlertDialog(
                              surfaceTintColor: Colors.white,
                              contentPadding: const EdgeInsets.all(16),
                              content: Form(
                                key: cubit.formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppTextField(
                                      label: 'Item',
                                      hint: 'Masukkan item',
                                      textController: cubit.cItemName,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return ('Item tidak boleh kosong');
                                        }

                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    AppButton(
                                      label: 'Simpan',
                                      onTap: () async {
                                        if (cubit.formKey.currentState!
                                            .validate()) {
                                          context.close();
                                          await cubit.putRenameItem(
                                            idChecklist: checklist.id,
                                            idItem: cubit.items[x].id,
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () => cubit.deleteItem(
                          idChecklist: checklist.id,
                          idItem: cubit.items[x].id,
                        ),
                        icon: const Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }

  FloatingActionButton _fabButton(
      BuildContext context, ChecklistCubit cubit, ChecklistModel checklist) {
    return FloatingActionButton(
      onPressed: () {
        context.show(
          child: AlertDialog(
            surfaceTintColor: Colors.white,
            contentPadding: const EdgeInsets.all(16),
            content: Form(
              key: cubit.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextField(
                    label: 'Item',
                    hint: 'Masukkan item',
                    textController: cubit.cItemName,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ('Item tidak boleh kosong');
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    label: 'Simpan',
                    onTap: () async {
                      if (cubit.formKey.currentState!.validate()) {
                        context.close();
                        await cubit.postSaveChecklistItem(
                            idChecklist: checklist.id);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
