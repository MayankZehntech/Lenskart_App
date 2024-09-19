part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool? emailError;
  final bool? passwordError;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool isFormValid;

  const LoginState({
    this.email = "",
    this.password = "",
    this.emailError,
    this.passwordError,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.isFormValid = false,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? emailError,
    bool? passwordError,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    bool? isFormValid,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError,
      passwordError: passwordError,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isFormValid: isFormValid ??
          _validateForm(email ?? this.email, password ?? this.password),
    );
  }

  static bool _validateForm(String email, String password) {
    return email.isNotEmpty && password.isNotEmpty;
  }

  @override
  List<Object?> get props => [
        email,
        password,
        emailError,
        passwordError,
        isSubmitting,
        isSuccess,
        isFailure,
        isFormValid
      ];
}

class LoginInitial extends LoginState {
  const LoginInitial() : super(email: '', password: '', isFormValid: false);
}

//for logout checking
class LogoutSuccess extends LoginState {
  const LogoutSuccess() : super(isFormValid: true);
}

class LogoutFail extends LoginState {
  final String error;
  const LogoutFail(this.error) : super(isFormValid: true);
}

class LogoutLoading extends LoginState {
  const LogoutLoading() : super(isFormValid: true);
}

class LoginLoading extends LoginState {
  const LoginLoading()
      : super(email: '', password: '', isSubmitting: true, isFormValid: false);
}

class LoginSuccess extends LoginState {
  const LoginSuccess()
      : super(email: '', password: '', isSuccess: true, isFormValid: false);
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure(this.error)
      : super(email: '', password: '', isFailure: true, isFormValid: false);

  @override
  List<Object> get props => [error];
}

class GoogleSigninSuccess extends LoginState {
  const GoogleSigninSuccess() : super(isSuccess: true);
}

class GoogleSigninLoading extends LoginState {
  const GoogleSigninLoading() : super(isSuccess: true);
}

class GoogleSigninFail extends LoginState {
  final String message;
  const GoogleSigninFail(this.message) : super(isSuccess: true);
}

class GoogleSigninError extends LoginState {
  final String message;
  // const GoogleSigninError() : super(isSuccess: true);
  const GoogleSigninError(this.message) : super(isSuccess: true);
}
