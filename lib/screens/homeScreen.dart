import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_shortner_service/bloc/auth_bloc_bloc.dart';
import 'package:url_shortner_service/bloc/url_shortner_bloc.dart';
import 'package:url_shortner_service/models/userModel.dart';
import 'package:url_shortner_service/screens/Login.dart';
import 'package:url_shortner_service/widgets/homeCard.dart';
import 'package:url_shortner_service/widgets/recentUrls.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final urlController = TextEditingController();

    context.read<UrlShortnerBloc>().add(UrlHomeInitialRequested());

    void onPressed(UserModel user) {
      context.read<UrlShortnerBloc>().add(
            UrlCreateRequest(
              user: user,
              orignalUrl: urlController.text.trim(),
            ),
          );
    }

    return BlocConsumer<UrlShortnerBloc, UrlShortnerState>(
      listener: (context, state) {
        if (state is AuthTokenNotFound) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        if (State is UrlLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UrlShortnerHome) {
          return Scaffold(
            appBar: AppBar(title: const Text("Home")),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: HomeCard(
                          onPressed: () {
                            onPressed(state.user);
                          },
                          urlController: urlController),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            borderRadius: BorderRadius.circular(20)),
                        height: 300,
                        child: RecentUrls(),
                      ),
                    ),
                    TextButton(
                      child: Text("view All"),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: SingleChildScrollView(),
          );
        }
      },
    );
  }
}
