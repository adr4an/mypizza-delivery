// Product fields
class CartItem {
  final String pizzaId;
  final String name;
  final String image;
  final int price;
  final int discount;
  final int spicyLabel;
  final bool isVeg;
  int quantity = 1;

  CartItem({
    required this.pizzaId,
    required this.name,
    required this.image,
    required this.price,
    required this.discount,
    required this.quantity,
    required this.isVeg,
    required this.spicyLabel,
  });
}
