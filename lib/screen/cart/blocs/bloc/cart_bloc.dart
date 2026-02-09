import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cart_repository/cart_repository.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepo cartRepo;
  late final StreamSubscription _cartSubscription;

  CartBloc(this.cartRepo) : super(CartInitial()) {

    // Listen to cart items stream and emit updates
    _cartSubscription = cartRepo.getCartItems().listen((items) {
      add(CartItemsUpdated(items));
    });

    on<CartItemsUpdated>((event, emit) {
      emit(CartLoaded(event.items));
    });

    on<AddToCart>((event, emit) {
      emit(CartLoading());
        try {
          cartRepo.addToCart(event.item);
          // emit empty state, actual items will come from stream
          emit(const CartLoaded([]));
        } catch (e) {
          emit(CartFailed());
        } 
    });

    on<RemoveFromCart>((event, emit) {
      try {
        cartRepo.deleteFromCart(event.itemId);
        // Stream listener will handle emitting updated items
      } catch (e) {
        emit(CartFailed());
      }
    });

    on<ClearCart>((event, emit) {
      try {
        cartRepo.clearCart();
        // Stream listener will handle emitting updated items
      } catch (e) {
        emit(CartFailed());
      }
    });

    on<IncrementCartItem>((event, emit) {
      emit(CartLoading());
      try {
        cartRepo.increaseQuantity(event.itemId);
      } catch (e) {
        emit(CartFailed());
      }
    });

    on<DecrementCartItem>((event, emit) {
      emit(CartLoading());
      try {
        cartRepo.decreaseQuantity(event.itemId);
      } catch (e) {
        emit(CartFailed());
      }
    });

  }

   // Dispose subscription when bloc is closed
  @override
  Future<void> close() {
    _cartSubscription.cancel();
    return super.close();
  }


}
