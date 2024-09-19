part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class GoogleSignInRequested extends LoginEvent {}

class LoginRequested extends LoginEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignupRequested extends LoginEvent {
  final String email;
  final String password;

  const SignupRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class EmailChanged extends LoginEvent {
  final String email;
  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends LoginEvent {
  final String password;
  const PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class PasswordVisibility extends LoginEvent {}

class LogoutRequested extends LoginEvent {}
