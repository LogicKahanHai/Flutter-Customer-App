import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginInitialEvent>((event, emit) async {
      emit(LoginLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      emit(LoginLoadedState());
    });
    on<LoginOtpContinueEvent>((event, emit) async {
      emit(LoginLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      emit(LoginOtpSentState());
    });
    on<OtpVerifyEvent>((event, emit) async {
      emit(OtpLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      if (event.otp != '1234') {
        emit(OtpErrorState());
        return;
      }
      emit(OtpSuccessState());
    });
  }
}
