import 'package:adealy/models/auth/sign_up_model.dart';

abstract class SignUpState {}

class SignUpInitialState extends SignUpState {}

class LoadingSignUpState extends SignUpState {}

class SuccessfulSignUpState extends SignUpState {
  //pass SignUp model here
}

class ErrorSignUpState extends SignUpState {
  final String error;

  ErrorSignUpState(this.error);
}

class ChangePasswordVisibilitySignUpState extends SignUpState {}

class ChangeConfirmPasswordVisibilitySignUpState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {
  SignUpSuccessState(SignUpModel signUpModel);
}

class SignUpErrorState extends SignUpState {
  SignUpErrorState(String error);
}

class ChangeVisibilitySignUpState extends SignUpState {}
class ChangeVisibilitySignUpLoadingState extends SignUpState {}
class ChangeVisibilitySignUpErrorState extends SignUpState {}
