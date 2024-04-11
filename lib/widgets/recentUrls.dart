import 'package:flutter/material.dart';
import 'package:url_shortner_service/models/urlModel.dart';

class RecentUrls extends StatelessWidget {
  RecentUrls({super.key, required this.list});
  final List<UrlModel> list;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: list.length > 6 ? 6 : list.length,
          itemBuilder: (context, index) {
            String orignalUrl = list[index].redirectUrl;
            String ShortId = list[index].shortId;
            return ListTile(
              contentPadding: EdgeInsets.all(5),
              title: Text(orignalUrl),
              subtitle: Text("http://localhost:3000/$ShortId)"),
            );
          }),
    );
  }
}
