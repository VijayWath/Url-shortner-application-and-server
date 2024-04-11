import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_shortner_service/bloc/url_shortner_bloc.dart';
import 'package:url_shortner_service/models/userModel.dart';
import 'package:url_shortner_service/respositories/urlRepository.dart';
import 'package:url_shortner_service/screens/AllUrlScreen.dart';
import 'package:url_shortner_service/screens/Login.dart';
import 'package:url_shortner_service/widgets/homeCard.dart';
import 'package:url_shortner_service/widgets/recentUrls.dart';
import 'package:url_shortner_service/widgets/urlCreatedBottomSheet.dart';

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

    void onViewAll(UserModel user) {
      context.read<UrlShortnerBloc>().add(
            GetAllUrlsRequested(user: user),
          );
    }

    void onCreateUrll(UserModel user) async {
      final _response = await UrlRepository().createNewUrl(
        orignalUrl: urlController.text,
        uid: user.uid,
      );
      if (_response.data != null) {
        UrlCreatedBottomSheet(url: _response.data.shortId).show(context);
        context.read<UrlShortnerBloc>().add(
              UrlReload(user: user),
            );
      }
      if (_response.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_response.error!),
          ),
        );
      }
      print("showing model Sheet");
    }

    return BlocConsumer<UrlShortnerBloc, UrlShortnerState>(
      listener: (context, state) {
        if (state is GetAllUrlsSuccess) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => AllUrlScreen(),
            ),
            ModalRoute.withName('/history'),
          );
        }
        if (state is AuthTokenNotFound) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        }
        if (state is UrlFailuar) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
      builder: (context, state) {
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
                            onCreateUrll((state as UrlShortnerHome).user);
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
                        height: 500,
                        child: RecentUrls(list: state.list),
                      ),
                    ),
                    TextButton(
                      child: Text("view All"),
                      onPressed: () {
                        onViewAll(state.user);
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
