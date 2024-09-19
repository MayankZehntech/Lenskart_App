import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lenskart_clone/services/current_location_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  bool isNavbarVisible = true;
  final LocationService locationService;

  HomeBloc(this.locationService) : super(HomeInitial()) {
    on<FetchLocation>(_onFetchLocation);

    on<ScrollUpEvent>((event, emit) {
      if (!isNavbarVisible) {
        isNavbarVisible = true;
        emit(NavbarVisibleState());
      }
    });

    on<ScrollDownEvent>((event, emit) {
      if (isNavbarVisible) {
        isNavbarVisible = false;
        emit(NavbarHiddenState());
      }
    });
  }

  FutureOr<void> _onFetchLocation(
      FetchLocation event, Emitter<HomeState> emit) async {
    emit(LocationLoading());
    try {
      final position = await locationService.getCurrentLocation();
      final cityName = await locationService.getCityFromCoordinates(position!);

      emit(LocationLoaded(position: position, cityName: cityName));
    } catch (error) {
      emit(LocationError(error.toString()));
    }
  }
}
