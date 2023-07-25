part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartInitEvent extends CartEvent {}

class CartAddProductEvent extends CartEvent {
  final ProductModel product;

  const CartAddProductEvent(this.product);

  @override
  List<Object> get props => [product];
}

class CartRemoveProductEvent extends CartEvent {
  final ProductModel product;

  const CartRemoveProductEvent(this.product);

  @override
  List<Object> get props => [product];
}
