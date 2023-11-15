import 'package:flutter/material.dart';
import 'package:sammilani_delegate/firebase/firebase_remote_config.dart';

import 'package:url_launcher/url_launcher.dart';

/// Flutter code sample for [AlertDialog].

class UpdateDialouge extends StatelessWidget {
  UpdateDialouge({super.key});
  final Uri _url = Uri.parse(
      'https://play.google.com/store/apps/details?id=com.tnsmobilesolutions.sammilani_delegate');
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    String updateText = RemoteConfigHelper().getMandatoryUpgradeText;
    String versionNumber = RemoteConfigHelper().getVersionNumber;
    return AlertDialog(
      title: Column(
        children: [
          const Text('Update your Application'),
          Text(versionNumber),
        ],
      ),
      content: Text(
        updateText,
        style: TextStyle(color: Colors.black),
      ),
      actions: <Widget>[
        Center(
          child: TextButton(
            onPressed: _launchUrl,
            child: const Text('Update'),
          ),
        ),
      ],
    );
  }
}
