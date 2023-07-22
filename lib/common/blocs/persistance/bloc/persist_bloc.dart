import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pk_customer_app/models/models.dart';
import 'package:pk_customer_app/repos/repos.dart';
import 'package:pk_customer_app/repos/user_repo.dart';

part 'persist_event.dart';
part 'persist_state.dart';

class PersistBloc extends HydratedBloc<PersistEvent, PersistState> {
  bool hasData = false;
  PersistBloc() : super(PersistInitial()) {
    on<PersistInitialEvent>((event, emit) {
      //[ ]: Add the code to populate the Cart and User Data in the Repo from the Local Storage
      try {
        if (UserRepo.isUser) {
          emit(PersistStateHasData());
        } else {
          emit(PersistStateEmpty());
        }
      } catch (e) {
        emit(PersistStateEmpty());
      }
    });

    on<PersistOnUserUpdateEvent>((event, emit) {
      //[ ]: Add the code to update the User Data in the Local Storage
      try {
        UserRepo.setUser = event.user;
        emit(PersistUserUpdated(user: event.user));
      } catch (e) {
        emit(PersistStateEmpty());
      }
    });

    on<PersistOnCartUpdateEvent>((event, emit) {
      //[ ]: Add the code to update the Cart Data in the Local Storage
      try {
        emit(PersistCartUpdated(cart: cartState));
      } catch (e) {
        emit(PersistStateEmpty());
      }
    });
  }

  @override
  PersistState? fromJson(Map<String, dynamic> json) {
    print(json);
    if (json['user'] == null) {
      print('PersistStateEmpty()');
      // return PersistStateEmpty();
      if (json['user'] != null) {
        UserRepo.setUser = UserModel.fromMap(json['user']);
      }
      if (json['cart'] != null) {
        print('json[cart]');
        print(CartModel.fromMap(json['cart']).products.length);
        cartState = CartModel.fromMap(json['cart']);
        print(cartState.products.length);
        ProductRepo.updateProducts();
      }
      return PersistStateHasData();
    } else {
      if (json['user'] != null) {
        UserRepo.setUser = UserModel.fromMap(json['user']);
      }
      if (json['cart'] != null) {
        cartState = CartModel.fromMap(json['cart']);
        ProductRepo.updateProducts();
      }
      return PersistStateHasData();
    }
  }

  @override
  Map<String, dynamic>? toJson(PersistState state) {
    if (state is PersistUserUpdated) {
      return state.toMap();
    } else if (state is PersistCartUpdated) {
      print(state.toMap());
      return state.toMap();
    } else {
      return null;
    }
  }
}
