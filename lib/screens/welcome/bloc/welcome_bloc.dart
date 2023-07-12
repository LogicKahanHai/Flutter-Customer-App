import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitial()) {
    on<WelcomeInitialEvent>(welcomeInitialEvent);
    on<WelcomeLoginEvent>(welcomeLoginEvent);
    on<WelcomeRegisterEvent>(welcomeRegisterEvent);
    on<WelcomeGuestEvent>(welcomeGuestEvent);
  }

  FutureOr<void> welcomeInitialEvent(
      WelcomeInitialEvent event, Emitter<WelcomeState> emit) async {
    emit(WelcomeLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(WelcomeLoadedState());
  }

  FutureOr<void> welcomeLoginEvent(
      WelcomeLoginEvent event, Emitter<WelcomeState> emit) {
    emit(WelcomeLoginActionState());
  }

  FutureOr<void> welcomeRegisterEvent(
      WelcomeRegisterEvent event, Emitter<WelcomeState> emit) {
    emit(WelcomeRegisterActionState());
  }

  FutureOr<void> welcomeGuestEvent(
      WelcomeGuestEvent event, Emitter<WelcomeState> emit) {
    emit(WelcomeGuestActionState());
  }
}
