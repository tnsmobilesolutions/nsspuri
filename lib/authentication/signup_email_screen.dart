import 'package:flutter/material.dart';
import 'package:sammilani_delegate/authentication/devotee_details.dart';
import 'package:sammilani_delegate/firebase/firebase_auth_api.dart';
import 'package:sammilani_delegate/theme/theme.dart';

import 'reset_password.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final textFieldFocusNode = FocusNode();
  bool _obscured = false;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/white-texture.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 150, 12, 0),
          child: Column(
            children: [
              Text(
                "Signup",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: emailController,
                onSaved: (newValue) => emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid Email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: " Enter your email",
                  labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Colors.grey.withOpacity(0.3),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none)),
                ),

                // hintText: 'Name',
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                onSaved: (newValue) => passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password';
                  }
                  return null;
                },
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscured,
                focusNode: textFieldFocusNode,
                decoration: InputDecoration(
                  labelText: " Enter your password",
                  labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
                  filled: true,

                  fillColor: Colors.grey.withOpacity(0.3),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none)),
                  floatingLabelBehavior: FloatingLabelBehavior
                      .never, //Hides label on focus or if filled

                  // Needed for adding a fill color

                  isDense: true, // Reduces height a bit

                  suffixIcon: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                    child: GestureDetector(
                      onTap: _toggleObscured,
                      child: Icon(
                        _obscured
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              TextFormField(
                controller: confirmPasswordController,
                onSaved: (newValue) => confirmPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm Pasword';
                  }
                  return null;
                },
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscured,
                decoration: InputDecoration(
                  labelText: " Confirm password",
                  labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
                  filled: true,

                  fillColor: Colors.grey.withOpacity(0.3),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none)),
                  floatingLabelBehavior: FloatingLabelBehavior
                      .never, //Hides label on focus or if filled

                  // Needed for adding a fill color

                  isDense: true, // Reduces height a bit

                  suffixIcon: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                    child: GestureDetector(
                      onTap: _toggleObscured,
                      child: Icon(
                        _obscured
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 21,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                margin: const EdgeInsets.fromLTRB(0, 11, 0, 11),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(90)),
                child: ElevatedButton(
                  onPressed: () async {
                    // String? uid = await FirebaseAuthentication()
                    //     .signupWithpassword(
                    //         emailController.text, passwordController.text);
                    // if (uid != null) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return DevoteeDetailsPage();
                      },
                    ));
                    // }
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.deepOrange;
                        }
                        return Colors.deepOrange;
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(90)))),
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
