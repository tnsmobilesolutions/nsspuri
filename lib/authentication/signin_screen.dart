// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sammilani_delegate/API/get_devotee.dart';
import 'package:sammilani_delegate/authentication/signup_email_screen.dart';
import 'package:sammilani_delegate/firebase/firebase_auth_api.dart';
import 'package:sammilani_delegate/home_page/home_page.dart';

import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/reusable_widgets/common_style.dart';
import 'package:sammilani_delegate/reusable_widgets/reusable_widgets.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';
import 'reset_password.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscured1 = true;
  final textFieldFocusNode = FocusNode();

  void _toggleObscured1() {
    setState(() {
      _obscured1 = !_obscured1;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ScaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  logoWidget("assets/images/nsslogo.png"),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _emailTextController,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(
                          RegExp(r'\s')), // Deny whitespace
                    ],
                    onSaved: (newValue) =>
                        _emailTextController.text = newValue!.trim(),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'This field is required';
                      }
                      if (!RegExp(
                        r'^[a-zA-Z0-9._%+$&-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                      ).hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    decoration: CommonStyle.textFieldStyle(
                      labelTextStr: 'Email',
                      hintTextStr: 'Enter Email',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _obscured1,
                      focusNode: textFieldFocusNode,
                      controller: _passwordTextController,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(
                            RegExp(r'\s')), // Deny whitespace
                      ],
                      onSaved: (newValue) => _passwordTextController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(12),
                        labelText: "Password",
                        labelStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                        hintText: "Password",
                        hintStyle:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 190, 190, 190)
                            .withOpacity(0.3),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                          child: GestureDetector(
                            onTap: _toggleObscured1,
                            child: Icon(
                              _obscured1
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              size: 20,
                              color: IconButtonColor,
                            ),
                          ),
                        ),
                      )

                      // hintText: 'Name',
                      ),
                  const SizedBox(height: 21),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        showDialog(
                          context: context,
                          barrierDismissible:
                              false, // Prevent dismissing by tapping outside
                          builder: (BuildContext context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );

                        // Navigate to the next screen
                        await Future.delayed(
                            const Duration(seconds: 1)); // Simulating a delay
                        try {
                          final uid =
                              await FirebaseAuthentication().signinWithFirebase(
                            _emailTextController.text.trim(),
                            _passwordTextController.text.trim(),
                          );
                          if (uid != null) {
                            final data = await GetDevoteeAPI()
                                .loginDevotee(uid.toString());
                            DevoteeModel devotee = data?["data"];
                            if (devotee.uid == uid) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Signin Successful')));
                              Navigator.of(context)
                                  .pop(); // Close the circular progress indicator
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return HomePage();
                                  },
                                ),
                              );
                            } else {
                              Navigator.of(context)
                                  .pop(); // Close the circular progress indicator
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Signin failed')));
                            }
                          } else {
                            Navigator.of(context)
                                .pop(); // Close the circular progress indicator
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Email doesn\'t exists or wrong password !')));
                          }
                        } catch (e) {
                          Navigator.of(context).pop();
                          if (e.toString().contains("Null")) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("No Devotee Found")));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          }
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return IconButtonColor;
                            }
                            return IconButtonColor;
                          }),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(90)))),
                      child: const Text(
                        "Sign In",
                      ),
                    ),
                  ),
                  forgetPassword(context),
                  signUpOption()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: TextThemeColor)),
        TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return SignupScreen(
                  title: "signup",
                );
              },
            ));
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.deepOrange,
          ),
          child: const Text(
            'Sign Up',
          ),
        )
      ],
    );
  }

  forgetPassword(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.deepOrange,
      ),
      child: const Text(
        "Forgot Password?",
        textAlign: TextAlign.right,
      ),
      onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ResetPasswordScreen())),
    );
  }
}
