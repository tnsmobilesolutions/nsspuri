import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sammilani_delegate/API/get_devotee.dart';
import 'package:sammilani_delegate/authentication/signin_screen.dart';
import 'package:sammilani_delegate/home_page/home_page.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? devoteeId;

  devoteedata(String uid) async {
    DevoteeModel devotee = await GetDevoteeAPI().loginDevotee(uid);
    devoteeId = devotee.devoteeId;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: const Image(
        image: AssetImage('assets/images/nsslogo.png'),
      ),
      splashIconSize: 200,
      splashTransition: SplashTransition.scaleTransition,
      nextScreen: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user == null) {
              return const SignInScreen();
            } else {
              return HomePage(
                uid: user.uid,
              );
            }
          } else {
            return SignInScreen();
          }
        },
      ),
    );
  }
}
