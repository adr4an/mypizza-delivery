import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzadelivery/app_view.dart';
import 'package:pizzadelivery/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:user_repository/user_repository.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  const MyApp({
    super.key,
    required this.userRepository,
  });

  @override
  Widget build(BuildContext context) {
    // Provide AuthenticationBloc using a Firebase-backed user repository
    return RepositoryProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(
          userRepository: userRepository
        ),
        child: const MyAppView(),
    );
  }
}