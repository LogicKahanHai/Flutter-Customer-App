// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

abstract class LoginActionState extends LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginLoadedState extends LoginState {}

class LoginOtpSentState extends LoginActionState {
  final String phone;

  LoginOtpSentState({
    required this.phone,
  });
}

class LoginErrorState extends LoginActionState {}
