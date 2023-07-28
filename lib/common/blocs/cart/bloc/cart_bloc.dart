import 'package:equatable/equatable.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pk_customer_app/models/models.dart';
import 'package:pk_customer_app/repos/repos.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends HydratedBloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<CartInitEvent>((event, emit) async {
      emit(CartLoading());

      await Future.delayed(const Duration(seconds: 1));
      try {
        if (state is CartLoaded) {
          emit(state);
        } else {
          emit(CartLoaded(products: CartRepo.products.toList()));
        }
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    });

    on<CartAddProductEvent>((event, emit) async {
      if (state is CartLoaded) {
        final index = (state as CartLoaded)
            .products
            .indexWhere((element) => element.id == event.product.id);
        if (index != -1) {
          emit(const CartError(message: 'Product already in cart'));
          return;
        }
        try {
          //TODO: add to cart
          // ProductRepo.addToCart(event.product.id);
          // CartRepo.products.add(ProductRepo.getProductById(event.product.id));
          emit(
            CartLoaded(products: CartRepo.products.toList()),
          );
        } catch (_) {}
      }
    });

    on<CartRemoveProductEvent>((event, emit) async {
      if (state is CartLoaded) {
        try {
          //TODO: remove from cart
          // ProductRepo.removeFromCart(event.product.id);
          // CartRepo.products.remove(event.product);
          emit(
            CartLoaded(
                products: List.from((state as CartLoaded).products)
                  ..remove(event.product)),
          );
        } catch (_) {}
      }
    });
  }

  @override
  CartState? fromJson(Map<String, dynamic> json) {
    try {
      final products = (json['products'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
      CartRepo.products = products.toSet();
      // for (ProductModel element in CartRepo.products.toList()) {
      //   ProductRepo.addToCart(element.id);
      //   ProductRepo.updateSelectedVariant(element.id, element.selectedVariant);
      // }
      return CartLoaded(products: products);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(CartState state) {
    if (state is CartLoaded) {
      return state.toJson();
    } else {
      return null;
    }
  }
}
