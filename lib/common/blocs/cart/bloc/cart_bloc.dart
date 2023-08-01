import 'package:equatable/equatable.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pk_customer_app/models/models.dart';
import 'package:pk_customer_app/repos/repos.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends HydratedBloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<CartInitEvent>((event, emit) async {
      try {
        if (state is CartLoaded) {
          emit(state);
        } else {
          // emit(CartLoaded(products: CartRepo.products.toList()));
          emit(CartLoaded(const []));
        }
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    });

    on<CartAddProductEvent>((event, emit) async {
      if (state is CartLoaded) {
        ProductModel product = ProductRepo.getProductById(event.productId)
            .copyWith(selectedVariant: event.variantId);
        try {
          //DONE: add to cart
          CartRepo.addProduct(product);
          
          // ProductRepo.addToCart(event.product.id);
          // CartRepo.products.add(ProductRepo.getProductById(event.product.id));
          //DONE: Make Cart State persistant.
          emit(
            CartLoaded(CartRepo.products),
          );
        } catch (_) {}
      }
    });

    // on<CartRemoveProductEvent>((event, emit) async {
    //   if (state is CartLoaded) {
    //     try {
    //       //TODDO: remove from cart
    //       // ProductRepo.removeFromCart(event.product.id);
    //       // CartRepo.products.remove(event.product);
    //       emit(
    //         CartLoaded(
    //             products: List.from((state as CartLoaded).products)
    //               ..remove(event.product)),
    //       );
    //     } catch (_) {}
    //   }
    // });
  }

  @override
  CartState? fromJson(Map<String, dynamic> json) {
    try {
      final products = (json['cartItems'] as List<dynamic>)
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList();
      // CartRepo.setCart(products);
      // for (ProductModel element in CartRepo.products.toList()) {
      //   ProductRepo.addToCart(element.id);
      //   ProductRepo.updateSelectedVariant(element.id, element.selectedVariant);
      // }
      return CartLoaded(products);
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
