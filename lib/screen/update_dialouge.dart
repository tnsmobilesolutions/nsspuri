import 'package:flutter/material.dart';
import 'package:sammilani_delegate/firebase/firebase_remote_config.dart';
import 'package:sammilani_delegate/screen/splash_screen.dart';

/// Flutter code sample for [AlertDialog].

class UpdateDialouge extends StatelessWidget {
  const UpdateDialouge({super.key});

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
      content: Text(updateText),
      actions: <Widget>[
        Center(
          child: TextButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SplashScreen(),
                )),
            child: const Text('Update'),
          ),
        ),
      ],
    );
  }
}
