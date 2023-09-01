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
          CartRepo.addProduct(product, event.quantity);

          emit(CartLoaded(CartRepo.products));
          hydrate();
        } catch (_) {}
      }
    });

    on<CartRemoveProductEvent>((event, emit) async {
      if (state is CartLoaded) {
        try {
          CartRepo.removeProduct(CartRepo.getCartItemById(event.cartItemId));
          emit(CartLoaded(CartRepo.products));
          hydrate();
        } catch (_) {}
      }
    });

    on<CartCreateOrderEvent>((event, emit) async {
      if (state is CartLoaded) {
        try {
          await CartRepo.sendPaymentMethodId(event.paymentMethod);
        } catch (_) {}
      }
    });
  }

  @override
  CartState? fromJson(Map<String, dynamic> json) {
    try {
      final products = (json['cartItems'] as List<dynamic>)
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList();
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
