import 'package:adealy/modules/login/cubit/states.dart';
import 'package:adealy/modules/sign-up/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);

  //var
  var passwordVisibilityState = true;
  var confirmPasswordVisibilityState = true;

  IconData suffix = Icons.visibility_outlined;
  IconData confirmSuffix = Icons.visibility_outlined;

  void changePasswordVisibilityState() {
    passwordVisibilityState = !passwordVisibilityState;
    suffix = passwordVisibilityState
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilitySignUpState());
  }

  void changeConfirmSuffixPasswordVisibilityState() {
    confirmPasswordVisibilityState = !confirmPasswordVisibilityState;
    confirmSuffix = confirmPasswordVisibilityState
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangeConfirmPasswordVisibilitySignUpState());
  }
}
