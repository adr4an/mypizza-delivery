import 'package:pizza_repository/src/entities/pizza_entity.dart';
import 'package:pizza_repository/src/models/macros.dart';

class Pizza {
  final String pizzaId;
  final String name;
  final String picture;
  final String description;

  final int price;
  final int discount;

  final int spicy;
  final bool isVeg;
  final Macros macros;

  Pizza({
    required this.pizzaId,
    required this.name,
    required this.picture,
    required this.description,
    required this.price,
    required this.discount,
    required this.spicy,
    required this.isVeg,
    required this.macros
  });

  // Convert Pizza to PizzaEntity
  PizzaEntity toEntity() {
    return PizzaEntity(
      pizzaId: pizzaId,
      name: name,
      picture: picture,
      description: description,
      price: price,
      discount: discount,
      spicy: spicy,
      isVeg: isVeg,
      macros: macros
    );
  }

  // Create Pizza from PizzaEntity
  static Pizza fromEntity(PizzaEntity entity) {
    return Pizza(
      pizzaId: entity.pizzaId,
      name: entity.name,
      picture: entity.picture,
      description: entity.description,
      price: entity.price,
      discount: entity.discount,
      spicy: entity.spicy,
      isVeg: entity.isVeg,
      macros: entity.macros
    );
  }

}