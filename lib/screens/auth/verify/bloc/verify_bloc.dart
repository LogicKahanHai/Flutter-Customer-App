import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pk_customer_app/repos/repos.dart';

part 'verify_event.dart';
part 'verify_state.dart';

class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
  VerifyBloc() : super(VerifyInitial()) {
    on<VerifyInitialEvent>((event, emit) async {
      try {
        emit(VerifyCodeSending());
        //? Send the code to the user

        List<dynamic> result = await AuthRepo.sendOtp(event.phone);
        if (result[0] == false) {
          emit(VerifyCodeSentFailure(
              error: 'Please enter a valid phone number'));
        } else {
          //? If the code is sent successfully, emit(VerifyCodeSentSuccess(phone: event.phone));

          emit(VerifyCodeSentSuccess(phone: event.phone, rid: result[1]));
        }

      } catch (error) {
        //? If the code is not sent successfully, emit(VerifyCodeSentFailure(error: error));
        
        emit(VerifyCodeSentFailure(error: error.toString()));
      }
    });

    on<VerifyFailureHandlerEvent>((event, emit) {
      emit(VerifyBackActionState(phone: event.phone));
    });

    on<VerifyCodeEvent>((event, emit) async {
      try {
        emit(VerifyLoading());

        //? Send an API call to verify the OTP or verify the OTP that came back with the Code Sent API call.

        final result =
            await AuthRepo.verifyOtp(event.phone, event.rid, event.code);

        //? Check the condition for success

        if (result[0] == true) {

          //? Emit Success Action State

          emit(VerifySuccess(
              phone: event.phone, token: result[2], uid: result[1]));
        } else {

          //? Emit Failure State if code is invalid

          emit(VerifyFailure(error: 'Invalid OTP'));
        }
      } catch (e) {

        //?Emit Failure for any other faliure
        
        emit(VerifyFailure(error: e.toString()));
      }
    });
  }
}
