abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String loginToken;

  LoginSuccessState(this.loginToken);
}

class LoginErrorState extends LoginStates {
  final dynamic error;

  LoginErrorState(this.error);
}

class ChangePasswordVisibilityState extends LoginStates {}
