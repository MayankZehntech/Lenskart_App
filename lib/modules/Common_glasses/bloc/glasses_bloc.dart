import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lenskart_clone/modules/Common_glasses/model/eyeglass_model.dart';
import 'package:lenskart_clone/services/firebase_service.dart';

part 'glasses_event.dart';
part 'glasses_state.dart';

class GlassesBloc extends Bloc<GlassesEvent, GlassesState> {
  final EyeglassService _eyeglassService;

  GlassesBloc(this._eyeglassService) : super(GlassesState()) {
    on<TabChanged>(_onTabChanged);
    on<ScrollUpdated>(_onScroll);
    // on<HideSectionImage>(_HideSectionImage);
    // on<ShowSectionImage>(_ShowSectionImage);
    on<FetchEyeglasses>(_fetchEyeglasses);
  }

  void _onTabChanged(TabChanged event, Emitter<GlassesState> emit) {
    emit(state.copyWith(selectedIndex: event.index));
  }

  void _onScroll(ScrollUpdated event, Emitter<GlassesState> emit) {
    // final isAppBarWhite = event.scrollPosition > 1;
    // final isTabSectionPinned = event.scrollPosition > 20;
    final isAppBarWhite = event.scrollPosition > 10;
    emit(state.copyWith(isAppBarWhite: isAppBarWhite));
    // if (event.scrollPosition > 50) {
    //   print('Mayank  ${event.scrollPosition}');
    //   emit(state.copyWith(isAppBarWhite: true, isTabSectionPinned: true));
    // } else
    //   print('Maynk asdfasdfadsf ${event.scrollPosition}');

    // emit(state.copyWith(isAppBarWhite: false, isTabSectionPinned: false));

    // emit(GlassesUpdated(
    //     selectedIndex: state.selectedIndex,
    //     isAppBarWhite: isAppBarWhite,
    //     isTabSectionPinned: isTabSectionPinned) as GlassesState);
  }

  // FutureOr<void> _HideSectionImage(
  //     HideSectionImage event, Emitter<GlassesState> emit) {
  //   emit(state.copyWith(showSectionImage: false));
  // }

  // FutureOr<void> _ShowSectionImage(
  //     ShowSectionImage event, Emitter<GlassesState> emit) {
  //   emit(state.copyWith(showSectionImage: true));
  // }

  FutureOr<void> _fetchEyeglasses(
      FetchEyeglasses event, Emitter<GlassesState> emit) async {
    emit(EyeglassLoading());
    //print("Mayank : 01 : ${event.genderType + event.glassesCategory}");

    try {
      print('Mayank hii');
      final eyeglasses = await _eyeglassService.fetchEyeglassesByCategory(
          event.genderType, event.glassesCategory);
      //print("Mayank : $eyeglasses");
      emit(EyeglassLoaded(eyeglasses: eyeglasses));
    } catch (e) {
      //print("Mayank : 05 : Error");
      emit(EyeglassError(message: e.toString()));
      //emit(EyeglassError(message: 'Failed to load eyeglasses'));
    }
  }
}
