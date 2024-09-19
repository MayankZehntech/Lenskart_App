import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lenskart_clone/services/user_info_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final UserInfoService _userInfoService;

  LoginBloc(this._firebaseAuth, this._googleSignIn, this._userInfoService)
      : super(const LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<SignupRequested>(_onSignupRequested);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LogoutRequested>(_onLogoutRequested);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
  }

  FutureOr<void> _onLoginRequested(
      LoginRequested event, Emitter<LoginState> emit) async {
    try {
      emit(const LoginLoading());
      await _firebaseAuth.signInWithEmailAndPassword(
          email: event.email, password: event.password);

      emit(const LoginSuccess());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  FutureOr<void> _onSignupRequested(
      SignupRequested event, Emitter<LoginState> emit) async {
    try {
      emit(const LoginLoading());
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: event.email, password: event.password);

      // Store user info after signup
      await _userInfoService.storeUserInfo(userCredential.user!);

      emit(const LoginSuccess());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  FutureOr<void> _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    final emailValid =
        !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(event.email);
    emit(state.copyWith(
      email: event.email,
      emailError: emailValid,
    ));
  }

  FutureOr<void> _onPasswordChanged(
      PasswordChanged event, Emitter<LoginState> emit) {
    final passwordValid = event.password.isNotEmpty;
    //print("Password : ${event.password}");
    emit(state.copyWith(
      password: event.password,
      passwordError: passwordValid,
    ));
  }

  FutureOr<void> _onLogoutRequested(
      LogoutRequested event, Emitter<LoginState> emit) async {
    try {
      //emit(const LoginLoading());

      await _googleSignIn.signOut();

      await _firebaseAuth.signOut();

      //await _googleSignIn.disconnect(); // Ensures complete logout from Google

      emit(const LogoutSuccess());
    } catch (e) {
      emit(LogoutFail(e.toString()));
    }
  }

  FutureOr<void> _onGoogleSignInRequested(
      GoogleSignInRequested event, Emitter<LoginState> emit) async {
    emit(const GoogleSigninLoading());
    try {
      // print('Attempting Google Sign-In');

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        // Store user info after Google sign-in
        await _userInfoService.storeUserInfo(user);
        emit(const GoogleSigninSuccess()); // Google sign-in was successful
      } else {
        emit(const GoogleSigninFail('Something went wrong'));
      }
    } catch (e) {
      emit(GoogleSigninError(e.toString()));
    }
  }
}
