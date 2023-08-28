import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:pk_customer_app/repos/repos.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>((event, emit) async {
      emit(HomeLoading());
      //TODO: Check for onReady type functionality.
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
              emit(HomeLoadedFailure(HomeLoadedFailureType.other));
              break;
            }
            final addressResponse = await UserRepo.getAndSetAddresses();
            if (!addressResponse) {
              emit(HomeLoadedFailure(HomeLoadedFailureType.other));
              break;
            }
            emit(HomeLoadedSuccess(
                address:
                    "${tempAddResponse[1]['sublocality_1'] ?? 'Unnamed'} - ${tempAddResponse[1]['city']} - ${tempAddResponse[1]['postcode']}"));
        }
      });
    });
  }
}
