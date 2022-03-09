import 'package:adealy/modules/login/cubit/cubit.dart';
import 'package:adealy/modules/login/cubit/states.dart';
import 'package:adealy/modules/sign-up/sign_up_screen.dart';
import 'package:adealy/shared/components/components.dart';
import 'package:adealy/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LoginCubit.get(context);

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
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
                    const SizedBox(
                      height: 35.0,
                    ),
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            defaultTextField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return "الرجاء إدخال رقم الهاتف الهاتف اولا";
                                }
                              },
                              label: "رقم التليفون",
                              prefix: Icons.phone_android,
                              onSubmit: (value) {
                                if (formKey.currentState!.validate()) {
                                  print(value);
                                }
                              },
                              onChange: (String value) {},
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
                            print(phoneController.text);
                            print(passwordController.text);
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
                        defaultTextButton(
                          function: () {
                            navigateAndFinishTo(context, const SignUpScreen());
                          },
                          text: 'انشاء حساب جديد',
                          isBold: true,
                          fontSizeColor: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
