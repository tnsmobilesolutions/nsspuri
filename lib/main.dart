import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:sammilani_delegate/firebase/firebase_options.dart';
import 'package:sammilani_delegate/firebase/firebase_remote_config.dart';
import 'package:sammilani_delegate/screen/splash_screen.dart';
import 'package:sammilani_delegate/screen/update_dialouge.dart';
import 'package:sammilani_delegate/utilities/app_theme_light.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await fetchRemoteConfigData();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
          AndroidServiceWorkerController.instance();

      await serviceWorkerController
          .setServiceWorkerClient(AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          print(request);
          return null;
        },
      ));
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    bool upgradePrompt = RemoteConfigHelper().getShowMandatoryUpgradePrompt;
    bool upgradeVersionAvailable =
        RemoteConfigHelper().getupdateRequiredByVersionnumber;

    print(
        "upgradePrompt --- $upgradePrompt, ----- upgradeVersionAvailable --- $upgradeVersionAvailable ");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: (upgradePrompt && upgradeVersionAvailable)
          ? UpdateDialouge()
          : const SplashScreen(),
    );
  }
}
