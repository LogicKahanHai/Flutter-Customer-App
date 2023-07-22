// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'persist_bloc.dart';

abstract class PersistState extends Equatable {
  const PersistState();

  @override
  List<Object> get props => [];
}

class PersistInitial extends PersistState {}

class PersistUserUpdated extends PersistState {
  final UserModel user;

  const PersistUserUpdated({required this.user});

  @override
  List<Object> get props => [user];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
    };
  }

  factory PersistUserUpdated.fromMap(Map<String, dynamic> map) {
    return PersistUserUpdated(
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory PersistUserUpdated.fromJson(String source) =>
      PersistUserUpdated.fromMap(json.decode(source) as Map<String, dynamic>);
}

class PersistCartUpdated extends PersistState {
  final CartModel cart;

  const PersistCartUpdated({required this.cart});

  @override
  List<Object> get props => [cart];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cart': cart.toMap(),
    };
  }

  factory PersistCartUpdated.fromMap(Map<String, dynamic> map) {
    return PersistCartUpdated(
      cart: CartModel.fromMap(map['cart'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory PersistCartUpdated.fromJson(String source) =>
      PersistCartUpdated.fromMap(json.decode(source) as Map<String, dynamic>);
}

class PersistStateEmpty extends PersistState {}

class PersistStateHasData extends PersistState {}
