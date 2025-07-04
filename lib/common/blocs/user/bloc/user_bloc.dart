import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pk_customer_app/models/models.dart';
import 'package:pk_customer_app/repos/repos.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends HydratedBloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserInitEvent>(
      (event, emit) {
        if (state is UserAuthState) {
          emit(state);
        } else {
          emit(const UserAuthState());
        }
      },
    );

    on<UserLoginEvent>((event, emit) {
      UserRepo(event.user);
      emit(UserAuthState(user: event.user));
      hydrate();
    });

    on<UserLogoutEvent>((event, emit) {
      emit(const UserAuthState());
      hydrate();
    });

    on<UserGetProfileEvent>((event, emit) async {
      emit(UserLoadingState());
      final profileExists = await UserRepo.profileExists();
      if (profileExists[0]) {
        final user = profileExists[1];
        emit(UserAuthState(user: user));
        hydrate();
        emit(UserProfileSuccessState());
      } else {
        emit(UserProfileDoesNotExistState());
      }
    });

    on<UserUpdateProfileEvent>((event, emit) async {
      emit(UserLoadingState());
      final response = await UserRepo.updateProfile(
        event.firstName,
        event.lastName,
      );
      if (response[0]) {
        emit(UserAuthState(user: response[1]));
        hydrate();
        return;
      }
      emit(const UserAuthState());
      hydrate();
      emit(UserProfileErrorState());
    });

    on<UserAddAddressEvent>((event, emit) async {
      emit(UserLoadingState());
      await UserRepo.addAddress(
        placeId: event.placeId,
        line1: event.address1,
        addressName: event.addressType,
        lat: event.lat,
        lng: event.lng,
        line2: event.address2,
        phone: event.phone,
      );
      emit(UserAuthState(user: UserRepo.user));
      hydrate();
    });

    on<UserRemoveAddressEvent>((event, emit) async {
      emit(UserLoadingState());
      final response = await UserRepo.removeAddress(event.id);
      if (response) {
        emit(UserAuthState(user: UserRepo.user));
        hydrate();
        return;
      }
      emit(UserAuthState(user: UserRepo.user));
      hydrate();
    });

    on<UserUpdateAddressEvent>((event, emit) async {
      emit(UserLoadingState());
      final response = await UserRepo.updateAddress(
        id: event.id,
        placeId: event.placeId,
        line1: event.address1,
        addressName: event.addressType,
        lat: event.lat,
        lng: event.lng,
        line2: event.address2,
        phone: event.phone,
      );
      if (response) {
        emit(UserAuthState(user: UserRepo.user));
        hydrate();
        return;
      }
      emit(UserAuthState(user: UserRepo.user));
      hydrate();
    });
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    try {
      return UserAuthState.fromMap(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    if (state is UserAuthState) {
      return state.toMap();
    }
    return null;
  }
}
