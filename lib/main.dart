
import 'package:flutter/material.dart';

import 'package:sammilani_delegate/authentication/signin_screen.dart';
import 'package:sammilani_delegate/theme/theme.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: FirebaseOptions(apiKey: "AIzaSyDlUZaghUvp0OSayMgnYisIoSlAzKUBSAQ", appId: "1:29623966317:android:97bc27c64fab7a5f667d64", messagingSenderId: "", projectId: "nsspuridelegate")
  // );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      home: const SignInScreen(),
    );
  }
}
