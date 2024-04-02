import 'package:url_shortner_service/bloc/auth_bloc_bloc.dart';
import 'package:url_shortner_service/respositories/UserRepository.dart';
import 'package:url_shortner_service/screens/CreateAccountScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBlocBloc(UserRepository()),
          ),
        ],
        child: MaterialApp(
          title: 'URL SERVICE',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const CreateAccountScreen(),
        ),
      ),
    );
  }
}
