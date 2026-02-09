import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pizzadelivery/app.dart';
import 'package:pizzadelivery/simple_bloc_observer.dart';
import 'package:user_repository/user_repository.dart';
import 'package:cart_repository/cart_repository.dart';

void main () async 
{
  // Hive Initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Custom Hive Adapters
  Hive.registerAdapter(CartItemAdapter());

  // delete and open cart items box
  await Hive.openBox<CartItem>('cart_items');

  // Firebase Initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 

  // Bloc observer initializationy
  Bloc.observer = SimpleBlocObserver();

  // Run the app
  runApp(
    MyApp(userRepository: FirebaseUserRepo(),)
  );

}



