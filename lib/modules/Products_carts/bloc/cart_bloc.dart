import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lenskart_clone/modules/Common_glasses/model/eyeglass_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<EyeglassModel> _cartItems = [];

  CartBloc() : super(CartInitial()) {
    on<AddToCart>(_onAddTocart);
    on<RemoveFromCart>(_onRemoveFromCart);
  }

  FutureOr<void> _onAddTocart(AddToCart event, Emitter<CartState> emit) {
    _cartItems.add(event.product);
    emit(CartUpdated(List.from(_cartItems)));
  }

  FutureOr<void> _onRemoveFromCart(
      RemoveFromCart event, Emitter<CartState> emit) {
    _cartItems.remove(event.product);
    if (_cartItems.isEmpty) {
      emit(CartEmpty()); // Emit a new state when cart is empty
    } else {
      emit(CartUpdated(List.from(_cartItems)));
    }
  }
}
