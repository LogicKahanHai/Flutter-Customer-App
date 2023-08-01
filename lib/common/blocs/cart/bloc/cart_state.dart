part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

abstract class CartActionState extends CartState {
  const CartActionState();
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemModel> cartItems;

  CartLoaded(this.cartItems) {
    if (CartRepo.products.isNotEmpty) {
      return;
    }
    if (cartItems.isNotEmpty) {
      CartRepo.setCart(cartItems);
      return;
    }
  }

  @override
  List<Object> get props => [cartItems];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'cartItems': cartItems.map((e) => e.toJson()).toList(),
    };
  }
}

class CartError extends CartActionState {
  final String message;

  const CartError({required this.message});

  @override
  List<Object> get props => [message];
}
