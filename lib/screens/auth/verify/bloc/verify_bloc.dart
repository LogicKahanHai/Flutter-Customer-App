import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'verify_event.dart';
part 'verify_state.dart';

class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
  VerifyBloc() : super(VerifyInitial()) {
    on<VerifyInitialEvent>((event, emit) async {
      try {
        emit(VerifyCodeSending());
        //? Send the code to the user
        await Future.delayed(const Duration(seconds: 2));
        //? If the code is sent successfully, emit(VerifyCodeSentSuccess(phone: event.phone));
        emit(VerifyCodeSentSuccess(phone: event.phone));
      } catch (error) {
        //? If the code is not sent successfully, emit(VerifyCodeSentFailure(error: error));
        emit(VerifyCodeSentFailure(error: error.toString()));
      }
    });

    on<VerifyFailureHandlerEvent>((event, emit) {
      emit(VerifyCodeSentSuccess(phone: event.phone));
    });

    on<VerifyCodeEvent>((event, emit) async {
      try {
        emit(VerifyLoading());
        //? Send an API call to verify the OTP or verify the OTP that came back with the Code Sent API call.
        await Future.delayed(const Duration(seconds: 1));
        //? Check the condition for success
        if (event.code == '1234') {
          //? Emit Success Action State
          emit(VerifySuccess());
        } else {
          //? Emit Failure State if code is invalid
          emit(VerifyFailure(error: 'Invalid Code'));
        }
      } catch (e) {
        //?Emit Failure for any other faliure
        emit(VerifyFailure(error: e.toString()));
      }
    });
  }
}
