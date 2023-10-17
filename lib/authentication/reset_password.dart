import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../reusable_widgets/reusable_widgets.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _newPasswodTextController = TextEditingController();
  TextEditingController _newTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        title: const Text(
          "Reset Password",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/white-texture.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  ReusableTextField("Enter Email Id", Icons.email, false,
                      _emailTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  ReusableTextField("Enter new Password", Icons.lock, false,
                      _emailTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  firebaseUIButton(context, "Reset Password", () {
                    FirebaseAuth.instance
                        .sendPasswordResetEmail(
                            email: _emailTextController.text)
                        .then((value) => Navigator.of(context).pop());
                  })
                ],
              ),
            ))),
      ),
    );
  }
}
