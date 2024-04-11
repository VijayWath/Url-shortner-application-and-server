import 'package:url_shortner_service/bloc/auth_bloc_bloc.dart';
import 'package:url_shortner_service/bloc/url_shortner_bloc.dart';
import 'package:url_shortner_service/bloc_observer.dart';
import 'package:url_shortner_service/respositories/UserRepository.dart';
import 'package:url_shortner_service/respositories/tokenRepository.dart';
import 'package:url_shortner_service/respositories/urlRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_shortner_service/screens/homeScreen.dart';

void main() {
  Bloc.observer = StateBlocObserver();
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
        RepositoryProvider(
          create: (context) => UrlRepository(),
        ),
        RepositoryProvider(
          create: (context) => TokenRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBlocBloc(UserRepository()),
          ),
          BlocProvider(
            create: (context) =>
                UrlShortnerBloc(UrlRepository(), TokenRepository()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'URL SERVICE',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
