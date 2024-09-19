part of 'wishlist_bloc.dart';

abstract class WishlistState extends Equatable {
  final List<EyeglassModel> wishlist;

  const WishlistState(this.wishlist);

  @override
  List<Object?> get props => [wishlist];
}

class WishlistInitial extends WishlistState {
  WishlistInitial() : super([]);
}

class WishlistUpdated extends WishlistState {
  const WishlistUpdated(super.wishlist);
}

// New state that checks if a particular product is wishlisted
class WishlistStatusChecked extends WishlistState {
  final bool isWishlisted;
  WishlistStatusChecked(this.isWishlisted) : super([]);

  @override
  List<Object> get props => [isWishlisted];
}
