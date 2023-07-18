part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

abstract class LoginActionState extends LoginState {}

abstract class OtpActionState extends LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginLoadedState extends LoginState {}

class LoginOtpSentState extends LoginActionState {}

class OtpLoadingState extends OtpActionState {}

class OtpSuccessState extends OtpActionState {}

class OtpErrorState extends OtpActionState {}
