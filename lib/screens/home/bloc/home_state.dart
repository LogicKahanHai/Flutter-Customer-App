part of 'home_bloc.dart';

enum HomeLoadedFailureType {
  locDenied,
  locDeniedForever,
  products,
  categories,
  variants,
  banners,
  other
}

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoadedSuccess extends HomeState {
  final String? address;

  HomeLoadedSuccess({this.address});
}

class HomeLoadedFailure extends HomeState {
  final HomeLoadedFailureType type;

  HomeLoadedFailure(this.type);
}

class HomeAddToCartSuccess extends HomeActionState {}

class HomeAddToCartFailure extends HomeActionState {}
