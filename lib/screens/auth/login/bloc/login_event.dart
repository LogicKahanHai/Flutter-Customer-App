part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

abstract class OtpEvent extends LoginEvent {}

class LoginInitialEvent extends LoginEvent {}

class LoginOtpContinueEvent extends LoginEvent {
  final String phone;

  LoginOtpContinueEvent({required this.phone});
}
