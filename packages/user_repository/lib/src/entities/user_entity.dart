// entity of the user

class MyUserEntity {
  String userId;
  String email;
  String name;
  bool hasActiveCart;

  MyUserEntity({
    required this.userId, 
    required this.email, 
    required this.name, 
    required this.hasActiveCart
  });

  // convert entity to json map
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'hasActiveCart': hasActiveCart,
    };
  }

  // convert json map to entity
  static MyUserEntity fromJson(Map<String, dynamic> json) {
    return MyUserEntity(
      userId: json['userId'],
      email: json['email'],
      name: json['name'],
      hasActiveCart: json['hasActiveCart'],
    );
  }


}