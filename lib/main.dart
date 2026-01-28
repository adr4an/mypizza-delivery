import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pizzadelivery/app.dart';
import 'package:pizzadelivery/simple_bloc_observer.dart';
import 'package:user_repository/user_repository.dart';

void main () async 
{
  // Firebase Initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 

  // Bloc observer initialization
  Bloc.observer = SimpleBlocObserver();

  // Run the app
  runApp(
    MyApp(userRepository: FirebaseUserRepo(),)
  );

}



