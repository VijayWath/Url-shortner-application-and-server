import 'package:flutter/material.dart';

class RecentUrls extends StatelessWidget {
  const RecentUrls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 6,
        itemBuilder: (context, int) {
          return ListTile(
            contentPadding: EdgeInsets.all(5),
            title: Text("orignal url"),
            subtitle: Text("short url"),
          );
        });
  }
}
