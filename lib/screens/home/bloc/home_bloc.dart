import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pk_customer_app/models/product_model.dart';
import 'package:pk_customer_app/repos/repos.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>((event, emit) async {
      emit(HomeLoading());
      await Future.delayed(const Duration(seconds: 2));
      emit(HomeLoadedSuccess());
    });

    on<HomeAddToCartEvent>((event, emit) async {
      ProductRepo.addToCart(event.product.id);
      cartState = cartState.addToCart(event.product);
      emit(HomeAddToCartSuccess());
      print('Added to cart');
      // emit(HomeLoadedSuccess());
    });
  }
}
