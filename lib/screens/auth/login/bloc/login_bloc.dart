import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginInitialEvent>((event, emit) async {
      emit(LoginLoadingState());
      emit(LoginLoadedState());
    });
    on<LoginOtpContinueEvent>((event, emit) async {
      try {
        emit(LoginLoadingState());
        emit(LoginOtpSentState(phone: event.phone));
      } catch (e) {
        emit(LoginErrorState());
        emit(LoginLoadedState());
      }
    });
  }
}
