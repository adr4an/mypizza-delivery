// Product fields
class CartItemEntites {
  final String pizzaId;
  final String name;
  final String image;
  final int calories;
  int quantity;
  final double price;
  final bool isVeg;

  CartItemEntites({
    required this.pizzaId,
    required this.name,
    required this.image,
    required this.calories,
    required this.price,
    required this.quantity,
    required this.isVeg,
  });

    
}
