part of 'glasses_bloc.dart';

class GlassesState extends Equatable {
  final int selectedIndex;
  // final bool showSectionImage;
  final bool isAppBarWhite;
  final bool isTabSectionPinned;

  GlassesState({
    this.isAppBarWhite = false,
    this.isTabSectionPinned = false,
    this.selectedIndex = 0,
  });

  GlassesState copyWith({
    int? selectedIndex,
    bool? isAppBarWhite,
    bool? isTabSectionPinned,
  }) {
    return GlassesState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isAppBarWhite: isAppBarWhite ?? this.isAppBarWhite,
      isTabSectionPinned: isTabSectionPinned ?? this.isTabSectionPinned,
    );
  }

  @override
  List<Object> get props => [selectedIndex, isAppBarWhite, isTabSectionPinned];
}

final class GlassesInitial extends GlassesState {}

class EyeglassInitial extends GlassesState {}

class EyeglassLoading extends GlassesState {}

class EyeglassLoaded extends GlassesState {
  final List<EyeglassModel> eyeglasses;

  EyeglassLoaded({required this.eyeglasses});

  @override
  List<Object> get props => [eyeglasses];
}

class EyeglassError extends GlassesState {
  final String message;

  EyeglassError({required this.message});

  @override
  List<Object> get props => [message];
}
