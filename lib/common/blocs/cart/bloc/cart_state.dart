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
  final List<ProductModel> products;

  const CartLoaded({required this.products});

  @override
  List<Object> get props => [products];

  Map<String, dynamic> toJson() {
    print('products: ${products.map((e) => e.toJson()).toList()}');
    return <String, dynamic>{
      'products': products.map((e) => e.toJson()).toList(),
    };
  }
}

class CartError extends CartActionState {
  final String message;

  const CartError({required this.message});

  @override
  List<Object> get props => [message];
}
