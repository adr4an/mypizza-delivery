import 'dart:async';
import 'package:cart_repository/cart_repository.dart';
import 'package:hive/hive.dart';

class FirebaseCartRepo implements CartRepo {
  static const String _boxName = 'cart_items';

  // Get the Hive box
  Box<CartItem> get _box => Hive.box<CartItem>(_boxName);

  @override
  Future<void> addToCart(CartItem item) async {
    final existingItem = _box.get(item.pizzaId);

    // If item already exists, update quantity
    if (existingItem != null) {
      existingItem.quantity += item.quantity;
      await _box.put(item.pizzaId, existingItem);
    } 

    // otherwise, add new item
    else {
      await _box.put(item.pizzaId, item);
    }
  }

  @override
  Stream<List<CartItem>> getCartItems() async* {
    final box = _box;

    // emit all the initial items
    yield box.values.toList();

    // listen for changes and emit updated list
    yield* box.watch().map((_) {
      return box.values.toList();
    });
  }

  @override
  Future<void> deleteFromCart(String id) async {
    await _box.delete(id);
  }

  @override
  Future<void> clearCart() async {
    await _box.clear();
  }

  @override
  Future<void> increaseQuantity(String id) async {
    final item = _box.get(id);

    // ensure item exists before trying to update
    if (item == null) return;

    item.quantity += 1;
    await _box.put(id, item);
  }
  
  @override
  Future<void> decreaseQuantity(String id) async {
    final item = _box.get(id);
    
    // ensure item exists before trying to update
    if (item == null) return;

    if (item.quantity > 1) {
      item.quantity -= 1;
      await _box.put(id, item);
    } else {
      await deleteFromCart(id);
    }
  }
}
