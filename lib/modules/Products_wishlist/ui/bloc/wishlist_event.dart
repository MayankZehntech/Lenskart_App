part of 'wishlist_bloc.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class AddToWishlist extends WishlistEvent {
  final EyeglassModel product;

  const AddToWishlist(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveFromWishlist extends WishlistEvent {
  final EyeglassModel product;

  const RemoveFromWishlist(this.product);

  @override
  List<Object> get props => [product];
}

//check the wishlist status when navigating back to the page.
class CheckWishlistStatus extends WishlistEvent {
  final EyeglassModel product;

  const CheckWishlistStatus(this.product);

  @override
  List<Object> get props => [product];
}
