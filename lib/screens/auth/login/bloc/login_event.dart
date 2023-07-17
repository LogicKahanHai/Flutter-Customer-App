part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

abstract class OtpEvent extends LoginEvent {}

class LoginInitialEvent extends LoginEvent {}

class LoginOtpContinueEvent extends LoginEvent {}

class OtpVerifyEvent extends OtpEvent {
  final String otp;

  OtpVerifyEvent({required this.otp});
}
