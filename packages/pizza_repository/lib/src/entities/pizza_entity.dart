import 'package:pizza_repository/src/entities/macros_entity.dart';
import 'package:pizza_repository/src/models/macros.dart';

class PizzaEntity {
  final String pizzaId;
  final String name;
  final String picture;
  final String description;
  final int price;
  final int discount;
  final int spicy;
  final bool isVeg;
  final Macros macros;

  PizzaEntity({
    required this.pizzaId,
    required this.name,
    required this.picture,
    required this.description,
    required this.price,
    required this.discount,
    required this.spicy,
    required this.isVeg,
    required this.macros,
  });

  
  // convert entity to json map
  Map<String, dynamic> toJson() {
    return {
      'pizzaId': pizzaId,
      'name': name,
      'picture': picture,
      'description': description,
      'price': price,
      'discount': discount,
      'spicy': spicy,
      'isVeg': isVeg,
      'macros': macros.toEntity().toJson(),
    };
  }

  // convert json map to entity
  static PizzaEntity fromJson(Map<String, dynamic> json) {
    return PizzaEntity(
      pizzaId: json['pizzaId'],
      name: json['name'],
      picture: json['picture'],
      description: json['description'],
      price: json['price'],
      discount: json['discount'],
      spicy: json['spicy'],
      isVeg: json['isVeg'],
      macros: Macros.fromEntity(
          MacrosEntity.fromJson(json['macros']),
      ),
    );
  }

}