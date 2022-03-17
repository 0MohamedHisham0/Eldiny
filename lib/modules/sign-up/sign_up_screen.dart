import 'package:adealy/layout/layout_screen.dart';
import 'package:adealy/modules/login/cubit/cubit.dart';
import 'package:adealy/modules/login/cubit/states.dart';
import 'package:adealy/modules/login/login_screen.dart';
import 'package:adealy/modules/sign-up/cubit/cubit.dart';
import 'package:adealy/modules/sign-up/cubit/states.dart';
import 'package:adealy/shared/components/components.dart';
import 'package:adealy/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var confirmPasswordController = TextEditingController();
    var passwordController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        var cubit = SignUpCubit.get(context);

        if (state is SignUpErrorState) {
          cubit.changeVisibilityState(true);
          cubit.changeVisibilityLoadingState(false);

          cubit.changeVisibilityErrorState(true);
          print("error ${cubit.signUpAcknowledgement}");
        }
        if (state is SignUpLoadingState) {
          cubit.changeVisibilityState(false);
          cubit.changeVisibilityLoadingState(true);
          cubit.changeVisibilityErrorState(false);
        }
        if (state is SignUpSuccessState) {
          navigateAndFinishTo(context, LayoutScreen());
        }
      },
      builder: (context, state) {
        var cubit = SignUpCubit.get(context);

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SingleChildScrollView(
                child: cubit.isVisibleSignUpScreen
                    ? Visibility(
                        visible: cubit.isVisibleSignUpScreen,
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'انشاء حساب جديد',
                              style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Visibility(
                              visible: cubit.isVisibleError,
                              child: Text(
                                cubit.signUpAcknowledgement,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    defaultTextField(
                                      controller: nameController,
                                      type: TextInputType.text,
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return "الرجاء إدخال اسمك اولا";
                                        }
                                      },
                                      label: "الاسم",
                                      prefix: Icons.person,
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
                                      height: 6.0,
                                    ),
                                    defaultTextField(
                                      controller: emailController,
                                      type: TextInputType.emailAddress,
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return "الرجاء إدخال البريد الاليكتروني اولا";
                                        }
                                      },
                                      label: "البريد الاليكتروني",
                                      prefix: Icons.email_outlined,
                                      onSubmit: (value) {
                                        if (formKey.currentState!.validate()) {
                                          print(value);
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 6.0,
                                    ),
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
                                    ),
                                    const SizedBox(
                                      height: 6.0,
                                    ),
                                    defaultTextField(
                                      isPassword:
                                          cubit.confirmPasswordVisibilityState,
                                      controller: confirmPasswordController,
                                      type: TextInputType.visiblePassword,
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return "الرجاء إدخال تأكيد الرقم السري اولا";
                                        }
                                        if (value != passwordController.text) {
                                          return "الرجاء التأكد من ان الرقمين مطابقين";
                                        }
                                      },
                                      label: "تأكيد الرقم السري",
                                      onSubmit: (value) {
                                        if (formKey.currentState!.validate()) {
                                          print(value);
                                        }
                                      },
                                      suffixPressed: () {
                                        cubit
                                            .changeConfirmSuffixPasswordVisibilityState();
                                      },
                                      suffix: cubit.confirmSuffix,
                                      prefix: Icons.lock_open,
                                    ),
                                    const SizedBox(
                                      height: 6.0,
                                    ),
                                    defaultTextField(
                                      isPassword: cubit.passwordVisibilityState,
                                      controller: passwordController,
                                      type: TextInputType.visiblePassword,
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return "الرجاء إدخال الرقم السري اولا";
                                        }
                                        if (value !=
                                            confirmPasswordController.text) {
                                          return "الرجاء التأكد من ان الرقمين مطابقين";
                                        }
                                      },
                                      label: "الرقم السري",
                                      onSubmit: (value) {
                                        if (formKey.currentState!.validate()) {
                                          print(value);
                                        }
                                      },
                                      suffixPressed: () {
                                        cubit.changePasswordVisibilityState();
                                      },
                                      suffix: cubit.suffix,
                                      prefix: Icons.lock_open,
                                    ),
                                  ],
                                )),
                            const SizedBox(
                              height: 6.0,
                            ),
                            defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    print(phoneController.text);
                                    print(passwordController.text);
                                    cubit.signUp(
                                        name: nameController.text.toString(),
                                        email: emailController.text.toString(),
                                        password:
                                            passwordController.text.toString(),
                                        phone: phoneController.text.toString());
                                  }
                                },
                                text: "انشاء الحساب",
                                width: double.infinity,
                                background: Colors.blue,
                                radius: 16),
                            const SizedBox(
                              height: 6.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  ' لديك حساب ؟',
                                ),
                                SizedBox(
                                  width: 100,
                                  child: defaultTextButton(
                                    function: () {
                                      navigateAndFinishTo(
                                          context, const LoginScreen());
                                    },
                                    text: 'تسجيل الدخول',
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
