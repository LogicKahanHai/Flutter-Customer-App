part of 'welcome_bloc.dart';

@immutable
abstract class WelcomeEvent {}

class WelcomeInitialEvent extends WelcomeEvent {}

class WelcomeLoginEvent extends WelcomeEvent {}

class WelcomeRegisterEvent extends WelcomeEvent {}

class WelcomeGuestEvent extends WelcomeEvent {}
