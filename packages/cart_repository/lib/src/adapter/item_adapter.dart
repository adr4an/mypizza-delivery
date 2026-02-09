import 'package:cart_repository/cart_repository.dart';
import 'package:hive/hive.dart';

class CartItemAdapter extends TypeAdapter<CartItem> {
  @override
  final int typeId = 1;

  @override
  CartItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{};

    for (int i = 0; i < numOfFields; i++) {
      final fieldKey = reader.readByte();
      fields[fieldKey] = reader.read();
    }

    return CartItem(
      pizzaId: fields[0] as String,
      name: fields[1] as String,
      image: fields[2] as String,
      quantity: fields[3] as int,
      price: fields[4] as int,
      spicyLabel: fields[5] as int,
      isVeg: fields[6] as bool, 
      discount: fields[7] as int, // Correctly reading index 7
    );
  }

  @override
  void write(BinaryWriter writer, CartItem obj) {
    // 1. Update this to 8 (pizzaId, name, image, quantity, price, spicy, isVeg, discount)
    writer.writeByte(8); 

    writer
      ..writeByte(0)
      ..write(obj.pizzaId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.spicyLabel)
      ..writeByte(6)
      ..write(obj.isVeg)
      // 2. Add the missing field index 7
      ..writeByte(7)
      ..write(obj.discount);
  }
}