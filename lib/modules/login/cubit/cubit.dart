import 'package:adealy/modules/login/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  //var
  var passwordVisibilityState = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibilityState() {
    passwordVisibilityState = !passwordVisibilityState;
    suffix = passwordVisibilityState
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityLoginState());
  }
}
