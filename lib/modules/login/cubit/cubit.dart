import 'package:adealy/models/auth/sign_up_model.dart';
import 'package:adealy/modules/login/cubit/states.dart';
import 'package:adealy/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  //var
  var passwordVisibilityState = true;
  IconData suffix = Icons.visibility_outlined;

  late SignUpModel signUpModel;

  bool isVisibleLoginScreen = true;
  bool isVisibleLoading = false;
  bool isVisibleError = false;
  var loginAcknowledgement = '';

  void changePasswordVisibilityState() {
    passwordVisibilityState = !passwordVisibilityState;
    suffix = passwordVisibilityState
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityLoginState());
  }

  //Auth Api
  void login({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postDataWithoutQuery(url: "api/users/login", data: {
      'email': email,
      'password': password,
    }).then((value) {
      signUpModel = SignUpModel.fromJson(value.data);
      var status = signUpModel.status.toString();
      var message = signUpModel.message.toString();

      print(status.toString());
      print(message.toString());

      if (status == "success") {
        emit(LoginSuccessState(signUpModel));
      }
      if (signUpModel.status == "failed" ||  signUpModel.status == "Failed") {
        signUpModel = SignUpModel.fromJson(value.data);
        print(message);
        loginAcknowledgement = message.toString();
        emit(LoginErrorState(message.toString()));
      }
    }).catchError((error) {
      print(error.toString());
      loginAcknowledgement = error.toString();
      emit(LoginErrorState(error.toString()));
    });
  }

  void changeVisibilityState(bool bool) {
    isVisibleLoginScreen = bool;
    emit(ChangeVisibilityLoginState());
  }

  void changeVisibilityLoadingState(bool bool) {
    isVisibleLoading = bool;
    emit(ChangeVisibilityLoginLoadingState());
  }

  void changeVisibilityErrorState(bool bool) {
    isVisibleError = bool;
    emit(ChangeVisibilityLoginErrorState());
  }
}
