import 'package:adealy/modules/login/cubit/cubit.dart';
import 'package:adealy/modules/login/cubit/states.dart';
import 'package:adealy/modules/sign-up/sign_up_screen.dart';
import 'package:adealy/network/local/CacheHelper.dart';
import 'package:adealy/shared/components/components.dart';
import 'package:adealy/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/layout_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        var cubit = LoginCubit.get(context);

        if (state is LoginErrorState) {
          cubit.changeVisibilityState(true);
          cubit.changeVisibilityLoadingState(false);
          cubit.changeVisibilityErrorState(true);

          print("error ${cubit.loginAcknowledgement}");
        }
        if (state is LoginLoadingState) {
          cubit.changeVisibilityState(false);
          cubit.changeVisibilityLoadingState(true);
          cubit.changeVisibilityErrorState(false);

        }
        if (state is LoginSuccessState) {
          var email = emailController.text.toString();
          var password = passwordController.text.toString();

          CacheHelper.saveData(key: "email", value: email);
          CacheHelper.saveData(key: "password", value: password);
          CacheHelper.saveData(key: "userId", value: state.loginModel.data!.id);
          CacheHelper.saveData(
                  key: "token", value: state.loginModel.data!.token.toString())
              .then((value) =>
                  {
                    navigateTo(context, const LayoutScreen())
                  }
          );
        }
      },
      builder: (context, state) {

        var cubit = LoginCubit.get(context);

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: cubit.isVisibleLoginScreen
                    ? Visibility(
                        visible: cubit.isVisibleLoginScreen,
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Visibility(
                              visible: cubit.isVisibleError,
                              child: Text(
                                cubit.loginAcknowledgement,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    defaultTextField(
                                      controller: emailController,
                                      type: TextInputType.emailAddress,
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return "الرجاء إدخال البريد الالكتروني اولا";
                                        }
                                      },
                                      label: "البريد الالكتروني",
                                      prefix: Icons.email,
                                      onSubmit: (value) {
                                        if (formKey.currentState!.validate()) {
                                          print(value);
                                        }
                                      },
                                      onChange: (String value) {
                                        cubit.changeVisibilityErrorState(false);
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    defaultTextField(
                                      isPassword: cubit.passwordVisibilityState,
                                      controller: passwordController,
                                      type: TextInputType.visiblePassword,
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return "الرجاء إدخال الرقم السري اولا";
                                        }
                                      },
                                      label: "الرقم السري",
                                      onSubmit: (value) {
                                        if (formKey.currentState!.validate()) {
                                          print(value);
                                        }
                                      },
                                      onChange: (String value) {},
                                      suffixPressed: () {
                                        cubit.changePasswordVisibilityState();
                                      },
                                      suffix: cubit.suffix,
                                      prefix: Icons.lock_open,
                                    ),
                                  ],
                                )),
                            const SizedBox(
                              height: 20.0,
                            ),
                            defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    print(emailController.text);
                                    print(passwordController.text);
                                    cubit.login(
                                        email: emailController.text.toString(),
                                        password:
                                            passwordController.text.toString());
                                  }
                                },
                                text: " تسحيل الدخول",
                                width: double.infinity,
                                background: Colors.blue,
                                radius: 16),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'ليس لديك حساب ؟',
                                ),
                                const SizedBox(
                                  width: 2.0,
                                ),
                                Container(
                                  width: 120,
                                  child: defaultTextButton(
                                    function: () {
                                      navigateTo(
                                          context, const LayoutScreen());
                                    },
                                    text: 'انشاء حساب جديد',
                                    isBold: true,
                                    fontSizeColor: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Visibility(
                        child: Center(
                          child: loadingShimmer(
                            height: 300,
                            width: 300,
                          ),
                        ),
                        visible: cubit.isVisibleLoading,
                      ),
              ),
            ),
          ),
        );
      },
    );

  }
}
