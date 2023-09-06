import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pk_customer_app/repos/repos.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>((event, emit) async {
      emit(HomeLoading());
      await GeoRepo.getCurrentLatLong().then((locationResponse) async {
        switch (locationResponse[0]) {
          case LocationPermission.denied:
            emit(HomeLoadedFailure(HomeLoadedFailureType.locDenied));
            break;
          case LocationPermission.deniedForever:
            emit(HomeLoadedFailure(HomeLoadedFailureType.locDeniedForever));
            break;

          default:
            final tempAddResponse =
                await UserRepo.setTemporaryAddress(locationResponse[1]);
            if (!tempAddResponse[0]) {
              if (kDebugMode) {
                print('Error setting temp address');
              }
              emit(HomeLoadedFailure(HomeLoadedFailureType.other));
              break;
            }
            final addressResponse = await UserRepo.getAndSetAddresses();
            if (!addressResponse) {
              if (kDebugMode) {
                print('Error getting addresses');
              }
              emit(HomeLoadedFailure(HomeLoadedFailureType.other));
              break;
            }
            //TODO: Add getCategories() here
            //TODO: Add getProducts() here

            final productsResponse =
                await ProductRepo.getProductsVariantsAndCategories();
            if (!productsResponse[0]) {
              emit(HomeLoadedFailure(productsResponse[1]));
              break;
            }
            //TODO: Add getBanners() here
            emit(HomeLoadedSuccess(
                address:
                    "${tempAddResponse[1]['sublocality_1'] ?? 'Unnamed'} - ${tempAddResponse[1]['city']} - ${tempAddResponse[1]['postcode']}"));
        }
      });
    });
  }
}
