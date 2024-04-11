import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_shortner_service/bloc/url_shortner_bloc.dart';
import 'package:url_shortner_service/models/urlModel.dart';
import 'package:url_shortner_service/models/userModel.dart';
import 'package:url_shortner_service/screens/homeScreen.dart';

class AllUrlScreen extends StatefulWidget {
  const AllUrlScreen({Key? key}) : super(key: key);

  @override
  State<AllUrlScreen> createState() => _AllUrlScreenState();
}

class _AllUrlScreenState extends State<AllUrlScreen> {
  void onHomeIconPressed(UserModel user) {
    context.read<UrlShortnerBloc>().add(
          UrlReload(user: user),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UrlShortnerBloc, UrlShortnerState>(
      listener: (context, state) {
        if (state is UrlShortnerHome) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            ModalRoute.withName('/'),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  onHomeIconPressed((state as GetAllUrlsSuccess).user);
                },
                icon: const Icon(Icons.home),
              ),
            ],
            title: const Text("Urls Created by you"),
          ),
          body: BlocBuilder<UrlShortnerBloc, UrlShortnerState>(
            builder: (context, state) {
              if (state is GetAllUrlsSuccess) {
                List<UrlModel> list = state.list;
                return Container(
                  padding: const EdgeInsets.all(8),
                  child: ListView.builder(
                    itemCount: list.length > 6 ? 6 : list.length,
                    itemBuilder: (context, index) {
                      String originalUrl = list[index].redirectUrl;
                      String shortId = list[index].shortId;
                      return ListTile(
                        contentPadding: EdgeInsets.all(5),
                        title: Text(originalUrl),
                        subtitle: Text("http://localhost:3000/$shortId"),
                      );
                    },
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
    );
  }
}
