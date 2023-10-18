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

class UserGetProfileEvent extends UserEvent {}

class UserUpdateProfileEvent extends UserEvent {
  final String firstName;
  final String lastName;
  const UserUpdateProfileEvent({
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object> get props => [firstName, lastName];
}

class UserAddAddressEvent extends UserEvent {
  final String placeId;
  final String address1;
  final String address2;
  final String addressType;
  final double lat;
  final double lng;
  final String phone;
  const UserAddAddressEvent({
    required this.placeId,
    required this.address1,
    required this.address2,
    required this.addressType,
    required this.lat,
    required this.lng,
    required this.phone,
  });

  @override
  List<Object> get props => [address1, address2, addressType, lat, lng];
}

class UserRemoveAddressEvent extends UserEvent {
  final String id;
  const UserRemoveAddressEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class UserUpdateAddressEvent extends UserEvent {
  final String id;
  final String placeId;
  final String address1;
  final String address2;
  final String addressType;
  final double lat;
  final double lng;
  final String phone;
  const UserUpdateAddressEvent({
    required this.id,
    required this.placeId,
    required this.address1,
    required this.address2,
    required this.addressType,
    required this.lat,
    required this.lng,
    required this.phone,
  });

  @override
  List<Object> get props => [address1, address2, addressType, lat, lng];
}
