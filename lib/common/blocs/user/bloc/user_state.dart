part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserAuthState extends UserState {
  final UserModel? user;
  const UserAuthState({
    this.user,
  });

  Map<String, dynamic> toMap() {
    if (user == null) return <String, dynamic>{'user': null};
    return <String, dynamic>{
      'user': user?.toJson(),
    };
  }

  factory UserAuthState.fromMap(Map<String, dynamic> map) {
    return UserAuthState(
      user: map['user'] != null
          ? UserModel.fromJson(map['user'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAuthState.fromJson(String source) =>
      UserAuthState.fromMap(json.decode(source) as Map<String, dynamic>);
}

class UserLoadingState extends UserState {}

class UserAddAddressSuccessState extends UserState {}
