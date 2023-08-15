import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pk_customer_app/models/models.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends HydratedBloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserInitEvent>((event, emit) {
      if (state is UserAuthState) {
        emit(state);
      } else {
        emit(const UserAuthState());
      }
    });

    on<UserLoginEvent>((event, emit) {
      emit(UserAuthState(user: event.user));
      hydrate();
    });

    on<UserLogoutEvent>((event, emit) {
      emit(const UserAuthState(user: null));
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
