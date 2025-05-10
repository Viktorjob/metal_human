import 'package:equatable/equatable.dart';


abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitted({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LoginWithGooglePressed extends LoginEvent {}

class RegisterSubmitted extends LoginEvent {
  final String email;
  final String password;

  RegisterSubmitted({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}


