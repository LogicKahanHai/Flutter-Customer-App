part of 'persist_bloc.dart';

abstract class PersistEvent extends Equatable {
  const PersistEvent();

  @override
  List<Object> get props => [];
}

class PersistInitialEvent extends PersistEvent {}

class PersistOnUserUpdateEvent extends PersistEvent {
  final UserModel user;

  const PersistOnUserUpdateEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class PersistOnCartUpdateEvent extends PersistEvent {
  final CartModel cart;

  const PersistOnCartUpdateEvent({required this.cart});

  @override
  List<Object> get props => [cart];
}
