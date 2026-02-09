part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class ClearCart extends CartEvent {}

class AddToCart extends CartEvent {
  final CartItem item;

  const AddToCart({required this.item});

  @override
  List<Object> get props => [item];
}

class RemoveFromCart extends CartEvent {
  final String itemId;

  const RemoveFromCart(this.itemId);

  @override
  List<Object> get props => [itemId];
}
  
// Internal event used by the bloc to receive stream updates
class CartItemsUpdated extends CartEvent {
  final List<CartItem> items;
  
  const CartItemsUpdated(this.items);

  @override
  List<Object> get props => [items];
}

class IncrementCartItem extends CartEvent {
  final String itemId;

  const IncrementCartItem({required this.itemId});

  @override
  List<Object> get props => [itemId];
}

class DecrementCartItem extends CartEvent {
  final String itemId;

  const DecrementCartItem({required this.itemId});

  @override
  List<Object> get props => [itemId];
}
