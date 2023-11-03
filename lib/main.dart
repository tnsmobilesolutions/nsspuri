import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:sammilani_delegate/firebase/firebase_options.dart';
import 'package:sammilani_delegate/screen/splash_screen.dart';
import 'package:sammilani_delegate/utilities/app_theme_dark.dart';
import 'package:sammilani_delegate/utilities/app_theme_light.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final ThemeData _delegateTheme = AppTheme.buildDelegateTheme();
final ThemeData _delegateThemeDark = AppThemeDark.buildDelegateTheme();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: Themes.light,
      // darkTheme: Themes.dark,
      theme: _delegateTheme,
   
      home: SplashScreen(),
    );
  }
}
