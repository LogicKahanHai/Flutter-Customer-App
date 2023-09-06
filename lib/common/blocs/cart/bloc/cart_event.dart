// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartInitEvent extends CartEvent {}

class CartAddProductEvent extends CartEvent {
  final int productId;
  final int variantId;
  final int quantity;
  const CartAddProductEvent({
    required this.productId,
    required this.variantId,
    this.quantity = 1,
  });

  @override
  List<Object> get props => [productId, variantId];
}

class CartRemoveProductEvent extends CartEvent {
  final String cartItemId;
  const CartRemoveProductEvent({
    required this.cartItemId,
  });

  @override
  List<Object> get props => [cartItemId];
}

class CartCreateOrderEvent extends CartEvent {
  final String addressId;
  final String paymentMethod;
  const CartCreateOrderEvent({
    required this.addressId,
    required this.paymentMethod,
  });

  @override
  List<Object> get props => [addressId, paymentMethod];
}

class CartClearEvent extends CartEvent {}
