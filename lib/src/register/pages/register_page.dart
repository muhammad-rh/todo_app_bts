import 'package:flutter/material.dart';
import 'package:todo_app_bts/env/class/app_env.dart';
import 'package:todo_app_bts/env/class/app_shortcut.dart';
import 'package:todo_app_bts/env/extension/on_context.dart';
import 'package:todo_app_bts/env/variable/app_constant.dart';
import 'package:todo_app_bts/env/widget/app_button.dart';
import 'package:todo_app_bts/env/widget/app_richtext.dart';
import 'package:todo_app_bts/env/widget/app_text.dart';
import 'package:todo_app_bts/env/widget/app_textfield.dart';
import 'package:todo_app_bts/src/register/cubit/register_cubit.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<RegisterCubit>();
    var my = AppShortcut.of(context);

    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (_, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: AbsorbPointer(
              absorbing: state is RegisterOnLoading ? true : false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 48),
                      const AppText(
                        text: 'Daftar Segera !',
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(height: 8),
                      AppText(
                        text:
                            'Daftarkan diri anda untuk bisa menikmati\nfitur dari kami',
                        textColor: my.color.onBackground,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: 'Email',
                        hint: 'Masukkan email anda',
                        textController: cubit.cEmail,
                        withIcon: false,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ('Email tidak boleh kosong');
                          }

                          return null;
                        },
                      ),
                      AppTextField(
                        label: 'Username',
                        hint: 'Masukkan username anda',
                        textController: cubit.cUsername,
                        keyboardType: TextInputType.text,
                        withIcon: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Username tidak boleh kosong';
                          }

                          return null;
                        },
                      ),

                      AppTextField(
                        isPassword: true,
                        label: 'Masukkan Kata Sandi',
                        hint: 'Masukkan Sandi Anda',
                        textController: cubit.cPassword,
                        withIcon: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ('Kata sandi tidak boleh kosong');
                          }

                          return null;
                        },
                      ),
                      // const SizedBox(height: 16),
                      AppTextField(
                        isPassword: true,
                        label: 'Masukkan Ulang Kata Sandi',
                        hint: 'Masukkan Ulang Sandi Anda',
                        textController: cubit.cPassconf,
                        withIcon: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ('Kata sandi tidak boleh kosong');
                          }

                          if (value != cubit.cPassword.text) {
                            return ('Kata sandi tidak sama');
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 16),
                      BlocConsumer<RegisterCubit, RegisterState>(
                        listener: (_, state) {
                          if (state is RegisterOnSuccess) {
                            context.alert(
                              label: 'Pendaftaran Berhasil!',
                              color: my.color.primary,
                            );
                            context.toNamed(route: AppRoute.loginPage.path);
                          }

                          if (state is RegisterOnFailed) {
                            context.alert(
                                label: state.message, color: my.color.error);
                          }

                          if (state is RegisterOnError) {
                            context.alert(
                              label: state.model.title,
                              color: my.color.error,
                            );
                          }
                        },
                        builder: (_, state) {
                          if (state is RegisterOnLoading) {
                            return const AppButtonloading();
                          }

                          return AppButton(
                            label: 'Daftar',
                            onTap: () {
                              if (cubit.formKey.currentState!.validate()) {
                                cubit.register(
                                  email: cubit.cEmail.text,
                                  username: cubit.cUsername.text,
                                  password: cubit.cPassword.text,
                                );
                              }
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () => context.toNamed(
                          route: AppRoute.loginPage.path,
                        ),
                        child: const Center(
                          child: AppRichText(
                            label: 'Sudah punya akun ? ',
                            labelColor: AppConstant.grey,
                            secLabel: 'Masuk',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
