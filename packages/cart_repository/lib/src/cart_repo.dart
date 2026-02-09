import 'models/models.dart' show CartItem;

// fetching pizza data from firestore
abstract class CartRepo {
  
  // add to cart
  Future<void> addToCart(CartItem item);

  // fetch all pizzas
  Stream<List<CartItem>> getCartItems();

  // delete from cart
  Future<void> deleteFromCart(String id);

  // remove all from cart
  Future<void> clearCart();

  // increase quantity
  Future<void> increaseQuantity(String id);

  // decrease quantity
  Future<void> decreaseQuantity(String id);

}