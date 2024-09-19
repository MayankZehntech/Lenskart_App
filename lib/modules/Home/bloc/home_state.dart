part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

class NavbarVisibleState extends HomeState {}

class NavbarHiddenState extends HomeState {}

//For location checking state
class LocationInitial extends HomeState {}

class LocationLoading extends HomeState {}

class LocationLoaded extends HomeState {
  final Position position;
  final String cityName;

  const LocationLoaded({required this.position, required this.cityName});

  @override
  List<Object> get props => [position, cityName];
}

class LocationError extends HomeState {
  final String error;

  const LocationError(this.error);

  @override
  List<Object> get props => [error];
}
