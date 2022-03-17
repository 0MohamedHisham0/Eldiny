import 'package:adealy/models/auth/sign_up_model.dart';
import 'package:adealy/modules/sign-up/cubit/states.dart';
import 'package:adealy/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);

  //var
  var passwordVisibilityState = true;
  var confirmPasswordVisibilityState = true;
  var signUpAcknowledgement = "";
  late SignUpModel signUpModel;

  bool isVisibleSignUpScreen = true;
  bool isVisibleLoading = false;
  bool isVisibleError = false;

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

  void changeVisibilityState(bool bool) {
    isVisibleSignUpScreen = bool;
    emit(ChangeVisibilitySignUpState());
  }

  void changeVisibilityLoadingState(bool bool) {
    isVisibleLoading = bool;
    emit(ChangeVisibilitySignUpLoadingState());
  }

  void changeVisibilityErrorState(bool bool) {
    isVisibleError = bool;
    emit(ChangeVisibilitySignUpErrorState());
  }

  //Auth Api
  void signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SignUpLoadingState());
    DioHelper.postDataWithoutQuery(url: "api/users", data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {

      signUpModel = SignUpModel.fromJson(value.data);

      var status = signUpModel.status;
      var message = signUpModel.message;

      if (status == "success") {
        emit(SignUpSuccessState(signUpModel));
      }
      if (signUpModel.status == "failed") {
        signUpModel = SignUpModel.fromJson(value.data);
         print(message);
        signUpAcknowledgement = message.toString();
        emit(SignUpErrorState(message.toString()));
      }
    }).catchError((error) {
      print(error.toString());
      signUpAcknowledgement = error.toString();
      emit(SignUpErrorState(error.toString()));
    });
  }
}
