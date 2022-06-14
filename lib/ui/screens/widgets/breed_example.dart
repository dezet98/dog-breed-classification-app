import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BreedExample extends StatefulWidget {
  final String breedName;

  const BreedExample({required this.breedName, Key? key}) : super(key: key);

  @override
  BreedExampleState createState() => BreedExampleState();
}

class BreedExampleState extends State<BreedExample> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    var loadingPercentage = 0;

    return Stack(
      children: [
        WebView(
          initialUrl: 'https://www.dogbreedslist.info/all-dog-breeds/'
              '${widget.breedName}.html',
          onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
        ),
        if (loadingPercentage < 100)
          LinearProgressIndicator(
            value: loadingPercentage / 100.0,
          ),
      ],
    );
  }
}
