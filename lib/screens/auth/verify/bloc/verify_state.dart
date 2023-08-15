// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'verify_bloc.dart';

@immutable
abstract class VerifyState {}

//? To Handle the Actions apart from the UI states
class VerifyActionState extends VerifyState {}

//? Initial State of the Verify Screen
class VerifyInitial extends VerifyState {}

//? State to show that the code is being sent to the user
class VerifyCodeSending extends VerifyState {}

//? State to show that the code has been sent to the user successfully
class VerifyCodeSentSuccess extends VerifyState {
  final String phone;
  final String rid;

  VerifyCodeSentSuccess({
    required this.phone,
    required this.rid,
  });
}

//? State to show that the code has NOT been sent to the user
class VerifyCodeSentFailure extends VerifyActionState {
  final String error;

  VerifyCodeSentFailure({required this.error});
}

//? State to show that the code is being verified
class VerifyLoading extends VerifyState {}

//? Action State to Navigate to the Home Screen on successful verification
class VerifySuccess extends VerifyActionState {
  final String phone;
  final String token;
  final String uid;

  VerifySuccess({
    required this.phone,
    required this.token,
    required this.uid,
  });
}

//? Action State to show Snackbar that the code is incorrect or any other error
class VerifyFailure extends VerifyActionState {
  final String error;

  VerifyFailure({required this.error});
}

//? Action State to Navigate the user to the Phone Screen
class VerifyBackActionState extends VerifyActionState {
  final String phone;

  VerifyBackActionState({required this.phone});
}
