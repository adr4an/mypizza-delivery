// Product fields
class CartItem {
  final String pizzaId;
  final String name;
  final String image;
  final int calories;
  int quantity;
  final double price;
  final bool isVeg;

  CartItem({
    required this.pizzaId,
    required this.name,
    required this.image,
    required this.calories,
    required this.price,
    required this.quantity,
    required this.isVeg,
  });
}
