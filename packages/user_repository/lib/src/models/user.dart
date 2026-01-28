// data of a user model
import 'package:user_repository/src/entities/entities.dart';

class MyUser {
  String userId;
  String email;
  String name;
  bool hasActiveCart;

  MyUser({
    required this.userId, 
    required this.email, 
    required this.name, 
    required this.hasActiveCart
  });

  // An empty user instance
  static final empty = MyUser(
    userId: '', 
    email: '', 
    name: '', 
    hasActiveCart: false
  );

  // Convert MyUser to MyUserEntity
  MyUserEntity toEntity() {
    return MyUserEntity(
      userId: userId,
      email: email,
      name: name,
      hasActiveCart: hasActiveCart,
    );
  }

  // Create MyUser from MyUserEntity
  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      userId: entity.userId,
      email: entity.email,
      name: entity.name,
      hasActiveCart: entity.hasActiveCart,
    );
  }

  @override
  String toString() {
    return 'MyUser(userId: $userId, email: $email, name: $name, hasActiveCart: $hasActiveCart)';
  }


}