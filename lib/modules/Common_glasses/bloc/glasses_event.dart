part of 'glasses_bloc.dart';

abstract class GlassesEvent extends Equatable {
  const GlassesEvent();

  @override
  List<Object> get props => [];
}

class TabChanged extends GlassesEvent {
  final int index;

  TabChanged(this.index);

  @override
  List<Object> get props => [index];
}

class ScrollUpdated extends GlassesEvent {
  final double scrollPosition;

  ScrollUpdated(this.scrollPosition);

  @override
  List<Object> get props => [scrollPosition];
}

class GlassesUpdated extends GlassesEvent {
  final int selectedIndex;
  final bool isAppBarWhite;
  final bool isTabSectionPinned;

  GlassesUpdated({
    required this.selectedIndex,
    required this.isAppBarWhite,
    required this.isTabSectionPinned,
  });

  @override
  List<Object> get props => [selectedIndex, isAppBarWhite, isTabSectionPinned];
}
// class HideSectionImage extends GlassesEvent {
//   @override
//   List<Object> get props => [];
// }

// class ShowSectionImage extends GlassesEvent {
//   @override
//   List<Object> get props => [];
// }

class FetchEyeglasses extends GlassesEvent {
  final String genderType;
  final String glassesCategory;

  const FetchEyeglasses(this.genderType, this.glassesCategory);

  @override
  List<Object> get props => [genderType, glassesCategory];
}
