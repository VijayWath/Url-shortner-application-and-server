import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UrlCreatedBottomSheet {
  final String url;
  UrlCreatedBottomSheet({required this.url});
  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 400,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color:
                                  Theme.of(context).colorScheme.onBackground)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: Text('http://localhost:3000/$url',
                          style: const TextStyle(fontSize: 15))),
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                    text: 'http://localhost:3000/$url'))
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Copied to your clipboard !'),
                                ),
                              );
                            });
                          },
                          child: Text(
                            "Copy",
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
