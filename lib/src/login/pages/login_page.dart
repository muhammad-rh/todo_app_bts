import 'package:flutter/material.dart';
import 'package:todo_app_bts/env/class/app_env.dart';
import 'package:todo_app_bts/env/class/app_shortcut.dart';
import 'package:todo_app_bts/env/extension/on_context.dart';
import 'package:todo_app_bts/env/variable/app_constant.dart';
import 'package:todo_app_bts/env/widget/app_button.dart';
import 'package:todo_app_bts/env/widget/app_richtext.dart';
import 'package:todo_app_bts/env/widget/app_text.dart';
import 'package:todo_app_bts/env/widget/app_textfield.dart';
import 'package:todo_app_bts/env/widget/bug_catcher.dart';
import 'package:todo_app_bts/src/login/cubit/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var my = AppShortcut.of(context);
    var cubit = context.read<LoginCubit>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                const AppText(
                  text: 'Selamat Datang !',
                  size: 18,
                  weight: FontWeight.bold,
                ),
                const SizedBox(height: 8),
                AppText(
                  text: 'Masuk ke akun anda untuk bisa menikmati\nTODO App.',
                  textColor: my.color.onBackground,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'Username',
                  hint: 'Masukkan username anda',
                  textController: cubit.cUsername,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ('Username tidak boleh kosong');
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AppTextField(
                  isPassword: true,
                  label: 'Sandi Anda',
                  hint: 'Masukkan sandi anda',
                  textController: cubit.cPassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ('Kata sandi tidak boleh kosong');
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (_, state) async {
                    if (state is LoginOnError) {
                      BugSheet.withModel(
                        state.model,
                        pagePath: 'login_page.dart',
                        statePath: 'login_cubit.dart',
                      ).openWith(context);
                    }

                    if (state is LoginOnFailed) {
                      context.alert(label: state.message);
                    }

                    if (state is LoginOnSuccess) {
                      context.removeToNamed(route: AppRoute.homePage.path);
                    }
                  },
                  builder: (_, state) {
                    if (state is LoginOnLoading) {
                      return const AppButtonloading();
                    }

                    return AppButton(
                      label: 'Masuk',
                      onTap: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.login(
                            username: cubit.cUsername.text,
                            password: cubit.cPassword.text,
                          );
                        }
                      },
                    );
                  },
                ),
                // const Spacer(),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () => context.toNamed(
                    route: AppRoute.registerPage.path,
                  ),
                  child: const Center(
                    child: AppRichText(
                      label: 'Belum punya akun ? ',
                      labelColor: AppConstant.grey,
                      secLabel: 'Daftar',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
