part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoadedSuccess extends HomeState {}

class HomeLoadedFailure extends HomeState {}

class HomeAddToCartSuccess extends HomeActionState {}

class HomeAddToCartFailure extends HomeActionState {}
