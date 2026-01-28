import 'package:pizza_repository/src/entities/macros_entity.dart';

class Macros {
  int protein;
  int fat;
  int calories;
  int carbs;

  Macros({
    required this.protein,
    required this.fat,
    required this.calories,
    required this.carbs,
  });

  MacrosEntity toEntity() {
    return MacrosEntity(
      protein: protein,
      fat: fat,
      calories: calories,
      carbs: carbs
    );
  }

  // Create Macros from MacrosEntity
  static Macros fromEntity(MacrosEntity entity) {
    return Macros(
      protein: entity.protein,
      fat: entity.fat,
      calories: entity.calories,
      carbs: entity.carbs
    );
  }

}
