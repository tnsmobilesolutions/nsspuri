import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class KnowMore extends StatelessWidget {
  const KnowMore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(top: 35),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context)
                  .size
                  .height, // Adjust the height as needed
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                    url: Uri.parse('https://punesammilani.nsspuri.org/')),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    useShouldOverrideUrlLoading: true,
                  ),
                ),
                onWebViewCreated: (controller) {
                  // You can use the controller to interact with the WebView
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  // Handle URL loading
                  return NavigationActionPolicy.ALLOW;
                },
              ),
            ),
          )),
    );
  }
}
