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
