import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_shortner_service/bloc/auth_bloc_bloc.dart';
import 'package:url_shortner_service/widgets/AuthInputFeild.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AuthInputFeild(controller: emailController, label: "Email"),
              AuthInputFeild(controller: passwordController, label: "Password"),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.account_balance_wallet_rounded),
                label: const Text("Login"),
              ),
              TextButton(
                  onPressed: () {
                    context.read<AuthBlocBloc>().add(AuthLoginRequested(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim()));
                  },
                  child: const Text("Create Account"))
            ],
          ),
        ),
      ),
    );
  }
}
