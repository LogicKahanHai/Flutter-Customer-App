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
          emit(const CartLoaded(cartItems: []));
        }
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    });

    on<CartAddProductEvent>((event, emit) async {
      if (state is CartLoaded) {
        print('in cart add product event');
        final index = (state as CartLoaded)
            .cartItems
            .indexWhere((element) => element.productId == event.product.id);
        if (index != -1) {
          emit(const CartError(message: 'Product already in cart'));
          return;
        }
        try {
          //TODO: add to cart
          CartRepo.addProduct(event.product);
          // ProductRepo.addToCart(event.product.id);
          // CartRepo.products.add(ProductRepo.getProductById(event.product.id));
          emit(
            CartLoaded(cartItems: CartRepo.cart.products.toList()),
          );
        } catch (_) {}
      }
    });

    // on<CartRemoveProductEvent>((event, emit) async {
    //   if (state is CartLoaded) {
    //     try {
    //       //TODO: remove from cart
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
    print('trying to load cart from json');
    try {
      final products = (json['cartItems'] as List<dynamic>)
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList();
      CartRepo.setCart(products);
      print(products);
      // for (ProductModel element in CartRepo.products.toList()) {
      //   ProductRepo.addToCart(element.id);
      //   ProductRepo.updateSelectedVariant(element.id, element.selectedVariant);
      // }
      return CartLoaded(cartItems: products);
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(CartState state) {
    if (state is CartLoaded) {
      print('in cart bloc to json');
      return state.toJson();
    } else {
      return null;
    }
  }
}
