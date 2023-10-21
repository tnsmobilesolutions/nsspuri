import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sammilani_delegate/authentication/signin_screen.dart';
import 'package:sammilani_delegate/home_page/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return AnimatedSplashScreen(
        splash: const Image(
          image: AssetImage('assets/images/nsslogo.png'),
        ),
        splashIconSize: 200,
        splashTransition: SplashTransition.scaleTransition,
        nextScreen: uid != null
            ? HomePage(
                uid: uid,
              )
            : const SignInScreen());
  }
}
