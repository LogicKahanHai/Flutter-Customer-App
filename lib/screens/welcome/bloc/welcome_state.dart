part of 'welcome_bloc.dart';

@immutable
abstract class WelcomeState {}

abstract class WelcomeActionState extends WelcomeState {}

class WelcomeInitial extends WelcomeState {}

class WelcomeLoadingState extends WelcomeState {}

class WelcomeLoadedState extends WelcomeState {}

class WelcomeLoginActionState extends WelcomeActionState {}

class WelcomeRegisterActionState extends WelcomeActionState {}

class WelcomeGuestActionState extends WelcomeActionState {}
