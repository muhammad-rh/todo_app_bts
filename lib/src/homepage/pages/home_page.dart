import 'package:flutter/material.dart';
import 'package:todo_app_bts/env/class/app_env.dart';
import 'package:todo_app_bts/env/class/app_shortcut.dart';
import 'package:todo_app_bts/env/extension/on_context.dart';
import 'package:todo_app_bts/env/variable/app_constant.dart';
import 'package:todo_app_bts/env/widget/app_button.dart';
import 'package:todo_app_bts/env/widget/app_card.dart';
import 'package:todo_app_bts/env/widget/app_confirmation_dialog.dart';
import 'package:todo_app_bts/env/widget/app_text.dart';
import 'package:todo_app_bts/env/widget/app_textfield.dart';
import 'package:todo_app_bts/env/widget/custom_app_bar.dart';
import 'package:todo_app_bts/src/homepage/cubit/homepage_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var my = AppShortcut.of(context);
    var cubit = context.watch<HomepageCubit>();

    return BlocListener<HomepageCubit, HomepageState>(
      listener: (_, state) {
        if (state is HomepageOnFailed) {
          context.alert(label: state.message, color: my.color.secondary);
        }

        if (state is HomepageOnError) {
          context.alert(label: state.model.title, color: my.color.error);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(label: 'TODO App', isBack: false),
        body: _buildBody(context, my, cubit),
        floatingActionButton: _fabButton(context, cubit),
      ),
    );
  }

  Stack _buildBody(BuildContext context, AppShortcut my, HomepageCubit cubit) {
    return Stack(
      children: [
        cubit.checklists.isEmpty
            ? const Center(
                child: AppText(
                  text: 'Belum ada checklist',
                  textColor: Colors.black,
                ),
              )
            : RefreshIndicator(
                onRefresh: () => cubit.getGetAllChecklist(),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    ...List.generate(
                      cubit.checklists.length,
                      (x) => AppCard(
                        backgroundColor: My.green3,
                        margin: const EdgeInsets.only(bottom: 8),
                        onTap: () {
                          context.toNamed(
                            route: AppRoute.checklistDetailPage.path,
                            arguments: {
                              'data': cubit.checklists[x],
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: AppText(
                                text: cubit.checklists[x].name,
                                textColor: Colors.black,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context.show(
                                  child: AppConfirmationDialog(
                                    title: 'Hapus Checklist?',
                                    subtitle:
                                        'Apakah anda ingin menghapus Checklist\n${cubit.checklists[x].name}',
                                    onYes: () => cubit.deleteChecklistById(
                                        id: cubit.checklists[x].id),
                                    onNo: () {},
                                  ),
                                );
                              },
                              icon: const Icon(Icons.delete_forever),
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        if (cubit.state is HomepageOnLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }

  FloatingActionButton _fabButton(BuildContext context, HomepageCubit cubit) {
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
                    label: 'Judul',
                    hint: 'Masukkan judul',
                    textController: cubit.cNameTodo,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ('Judul tidak boleh kosong');
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
                        await cubit.postSaveChecklist();
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
