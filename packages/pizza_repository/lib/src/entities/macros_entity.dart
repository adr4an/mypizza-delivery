class MacrosEntity {
  final int protein;
  final int fat;
  final int calories;
  final int carbs;

  MacrosEntity({
    required this.protein,
    required this.fat,
    required this.calories,
    required this.carbs,
  });

  
  // convert entity to json map
  Map<String, dynamic> toJson() {
    return {
      'protein': protein,
      'fat': fat,
      'calories': calories,
      'carbs': carbs,
    };
  }

  // convert json map to entity
  static MacrosEntity fromJson(Map<String, dynamic> json) {
    return MacrosEntity(
      protein: json['protein'] ?? 0,
      fat: json['fat'] ?? 0,
      calories: json['calories'] ?? 0,
      carbs: json['carbs'] ?? 0,
    );
  }

}