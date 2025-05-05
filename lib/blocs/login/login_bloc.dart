import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<RegisterSubmitted>(_onRegisterSubmitted);

  }


  Future<void> _onLoginSubmitted(
      LoginSubmitted event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginLoading());
    try {
      await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }


  Future<void> _onRegisterSubmitted(
      RegisterSubmitted event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginLoading());
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      // Отправляем письмо с подтверждением
      await userCredential.user?.sendEmailVerification();

      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit( LoginFailure('Этот email уже зарегистрирован.'));
      } else if (e.code == 'invalid-email') {
        emit( LoginFailure('Неверный формат email.'));
      } else if (e.code == 'weak-password') {
        emit(LoginFailure('Пароль слишком слабый (минимум 6 символов).'));
      } else {
        emit(LoginFailure(e.message ?? 'Ошибка при регистрации.'));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }




}
