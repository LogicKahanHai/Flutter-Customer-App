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
  const CartAddProductEvent(
    this.productId,
    this.variantId,
  );

  @override
  List<Object> get props => [productId, variantId];
}

class CartRemoveProductEvent extends CartEvent {
  final ProductModel product;

  const CartRemoveProductEvent(this.product);

  @override
  List<Object> get props => [product];
}
