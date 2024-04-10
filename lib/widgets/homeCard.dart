import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_shortner_service/bloc/url_shortner_bloc.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    // required this.state,
    required this.urlController,
    required this.onPressed,
    super.key,
  });

  // final UrlShortnerState state;
  final TextEditingController urlController;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: urlController,
                decoration: InputDecoration(
                  label: const Text("Enter your looooong url"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Align(
              child: ElevatedButton(
                onPressed: onPressed,
                child: const Text("Create"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
