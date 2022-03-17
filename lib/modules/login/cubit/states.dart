import 'package:adealy/models/auth/sign_up_model.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoadingLoginState extends LoginState {}

class SuccessfulLoginState extends LoginState {
  //pass login model here
}

class ErrorLoginState extends LoginState {
  final String error;

  ErrorLoginState(this.error);
}

class ChangePasswordVisibilityLoginState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final SignUpModel loginModel;
  LoginSuccessState(this.loginModel);

}

class LoginErrorState extends LoginState {
  LoginErrorState(String error);
}

class ChangeVisibilityLoginState extends LoginState {}
class ChangeVisibilityLoginLoadingState extends LoginState {}
class ChangeVisibilityLoginErrorState extends LoginState {}
