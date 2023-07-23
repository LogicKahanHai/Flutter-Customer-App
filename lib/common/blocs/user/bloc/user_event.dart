// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserInitEvent extends UserEvent {}

class UserLoginEvent extends UserEvent {
  final UserModel user;
  const UserLoginEvent({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class UserLogoutEvent extends UserEvent {}
