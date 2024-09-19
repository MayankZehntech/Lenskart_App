part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class ScrollUpEvent extends HomeEvent {}

class ScrollDownEvent extends HomeEvent {}

class FetchLocation extends HomeEvent {
  @override
  List<Object> get props => [];
}
