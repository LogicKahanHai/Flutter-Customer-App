import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pk_customer_app/models/product_model.dart';
import 'package:pk_customer_app/repos/product_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>((event, emit) async {
      emit(HomeLoading());
      await ProductRepo().getProducts();
      await Future.delayed(const Duration(seconds: 2));
      emit(HomeLoadedSuccess());
    });

  }
}
