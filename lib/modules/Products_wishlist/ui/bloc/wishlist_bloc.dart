import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lenskart_clone/modules/Common_glasses/model/eyeglass_model.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<AddToWishlist>(_AddToWishlist);
    on<RemoveFromWishlist>(_RemoveFromWishlist);
    on<CheckWishlistStatus>(_CheckWishlistStatus);
  }

  FutureOr<void> _AddToWishlist(
      AddToWishlist event, Emitter<WishlistState> emit) {
    final updatedWishlist = List<EyeglassModel>.from(state.wishlist)
      ..add(event.product);
    emit(WishlistUpdated(updatedWishlist));
  }

  FutureOr<void> _RemoveFromWishlist(
      RemoveFromWishlist event, Emitter<WishlistState> emit) {
    final updatedWishlist = List<EyeglassModel>.from(state.wishlist)
      ..remove(event.product);
    emit(WishlistUpdated(updatedWishlist));
  }

  FutureOr<void> _CheckWishlistStatus(
      CheckWishlistStatus event, Emitter<WishlistState> emit) {
    final isWishlisted = state.wishlist.contains(event.product);
    emit(WishlistStatusChecked(isWishlisted));
  }
}
