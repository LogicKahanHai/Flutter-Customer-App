part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeAddToCartEvent extends HomeEvent {
  final ProductModel product;
  HomeAddToCartEvent({required this.product});
}
