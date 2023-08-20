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

class UserAddAddressEvent extends UserEvent {
  final String address1;
  final String address2;
  final String addressType;
  final String lat;
  final String lon;
  const UserAddAddressEvent({
    required this.address1,
    required this.address2,
    required this.addressType,
    required this.lat,
    required this.lon,
  });

  @override
  List<Object> get props => [address1, address2, addressType, lat, lon];
}
