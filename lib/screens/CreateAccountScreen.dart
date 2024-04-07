// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_shortner_service/bloc/auth_bloc_bloc.dart';
import 'package:url_shortner_service/screens/Login.dart';
import 'package:url_shortner_service/screens/homeScreen.dart';
import 'package:url_shortner_service/widgets/AuthInputFeild.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Account",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: BlocConsumer<AuthBlocBloc, AuthBlocState>(
          listener: (context, state) {
            if (state is AuthFailuare) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
            if (state is AuthSuccess) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => HomeScreen(),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  AuthInputFeild(controller: nameController, label: "Name"),
                  AuthInputFeild(controller: emailController, label: "Email"),
                  AuthInputFeild(
                      controller: passwordController, label: "Password"),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20)),
                    onPressed: () {
                      context.read<AuthBlocBloc>().add(
                            AuthCreateAccountRequested(
                              email: emailController.text.trim(),
                              name: nameController.text.trim(),
                              password: passwordController.text.trim(),
                            ),
                          );
                    },
                    icon: const Icon(Icons.account_balance_wallet_rounded),
                    label: const Text("Create Account"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: const Text("Already have and accounr"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
