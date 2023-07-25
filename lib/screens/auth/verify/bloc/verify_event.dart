// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'verify_bloc.dart';

@immutable
abstract class VerifyEvent {}

//? Event to initalise and send the code to the user
class VerifyInitialEvent extends VerifyEvent {
  final String phone;

  VerifyInitialEvent({required this.phone});
}

//? Event to verify the code that the user entered
class VerifyCodeEvent extends VerifyEvent {
  final String phone;
  final String code;

  VerifyCodeEvent({required this.phone, required this.code});
}

//? Event to resend the code to the user
class VerifyResendEvent extends VerifyEvent {
  final String phone;

  VerifyResendEvent({required this.phone});
}

//? Event to navigate to the Phone Screen
class VerifyBackEvent extends VerifyEvent {}

class VerifyFailureHandlerEvent extends VerifyEvent {
  final String phone;
  VerifyFailureHandlerEvent({
    required this.phone,
  });
}
