import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_shortner_service/bloc/auth_bloc_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authState =
        context.watch<AuthBlocBloc>().state as AuthCreateAccountSuccess;
    return Center(
        child: Container(
      child: Text("s"),
    ));
  }
}
