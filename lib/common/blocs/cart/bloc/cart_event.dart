// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartInitEvent extends CartEvent {}

class CartAddProductEvent extends CartEvent {
  final String productId;
  final String variantId;
  final int quantity;
  const CartAddProductEvent(
    {
    required this.productId,
    required this.variantId,
    this.quantity = 1,
  }
  );

  @override
  List<Object> get props => [productId, variantId];
}

class CartRemoveProductEvent extends CartEvent {
  final String productId;
  final String variantId;
  const CartRemoveProductEvent(
    this.productId,
    this.variantId,
  );

  @override
  List<Object> get props => [productId, variantId];
}
