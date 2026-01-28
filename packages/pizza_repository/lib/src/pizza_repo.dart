import 'models/models.dart' show Pizza;

// fetching pizza data from firestore
abstract class PizzaRepo {
  
  Future<List<Pizza>> getPizzas();

}