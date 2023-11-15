import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isAppNeedUpdate = false;

  getVersionNumber() async {
    String remoteVersion = RemoteConfigHelper().getVersionNumber;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;
    print('Version: $appVersion, remoteVersion: $remoteVersion');
    if (appVersion == remoteVersion) {
      isAppNeedUpdate = false;
    } else if (appVersion.compareTo(remoteVersion) < 0) {
      isAppNeedUpdate = true;
    } else {
      isAppNeedUpdate = false;
    }
  }

  @override
  void initState() {
    super.initState();
    getVersionNumber();
  }

  @override
  Widget build(BuildContext context) {
    print("isAppNeedUpdate : $isAppNeedUpdate");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: (RemoteConfigHelper().getShowMandatoryUpgradePrompt &&
              isAppNeedUpdate)
          ? UpdateDialouge()
          : const SplashScreen(),
    );
  }
}
