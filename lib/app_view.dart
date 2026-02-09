import 'package:cart_repository/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'package:pizzadelivery/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pizzadelivery/screen/auth/blocs/sign_in_bloc/bloc/sign_in_bloc.dart';
import 'package:pizzadelivery/screen/auth/views/welcome_screen.dart';
import 'package:pizzadelivery/screen/cart/blocs/bloc/cart_bloc.dart';
import 'package:pizzadelivery/screen/home/blocs/get_pizza/get_pizza_bloc.dart';
import 'package:pizzadelivery/screen/home/views/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // default theme
      theme: ThemeData(
        colorScheme: ColorScheme.light(
        surface: Colors.grey.shade100,
        onSurface: Colors.black,
        primary: Colors.blue,
        onPrimary: Colors.white,
      )),

      // depending on authentication state show home screen or welcome screen
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          // user authenticated
          if (state.status == AuthenticationStatus.authenticated) 
          {
            return MultiBlocProvider(
              providers: [
                // sign in bloc
                BlocProvider<SignInBloc>(
                  create: (context) => SignInBloc(
                    context.read<AuthenticationBloc>().userRepository,
                  ),
                ),
                
                // 
                BlocProvider<GetPizzaBloc>(
                  create: (context) => GetPizzaBloc(
                    FirebasePizzaRepo(),
                  )..add(GetPizza()),
                  // add() sends an event to the bloc
                ),

                BlocProvider<CartBloc>(
                  create: (context) => CartBloc(
                    FirebaseCartRepo(),
                  ),
                  // add() sends an event to the bloc
                ),
              ],

              child: const HomeScreen(),
            );
          }

          // user unauthicated
          else {
            return const WelcomeScreen();
          }
        },
      ),

    );
  }
}