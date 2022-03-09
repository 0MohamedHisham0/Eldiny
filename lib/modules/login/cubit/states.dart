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
