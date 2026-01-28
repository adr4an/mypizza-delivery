import 'dart:developer';

import 'package:pizza_repository/pizza_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebasePizzaRepo implements PizzaRepo {
  final pizzaCollection = FirebaseFirestore.instance.collection('pizzas');

  // get the pizza list from firestore
  @override
  Future<List<Pizza>> getPizzas() async {
    try {
      return await pizzaCollection
        .get() // return a snapshot of all docs
        .then((value) => value.docs.map((e) => 
          Pizza.fromEntity(PizzaEntity.fromJson(e.data()))
          ).toList()
        );
    } catch (e) {
      // print the error to console
      log(e.toString());
      rethrow;
    }
  }

}