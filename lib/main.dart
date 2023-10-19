import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'package:sammilani_delegate/firebase/firebase_options.dart';
import 'package:sammilani_delegate/screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: Themes.light,
      // darkTheme: Themes.dark,
      home: SplashScreen(),
    );
  }
}
