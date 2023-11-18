// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

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
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    style: Theme.of(context).textTheme.displaySmall,
                    controller: _emailTextController,
                    onSaved: (newValue) => _emailTextController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid Email';
                      }
                      return null;
                    },
                    decoration: CommonStyle.textFieldStyle(
                        labelTextStr: "Email", hintTextStr: "Enter Email"),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    style: Theme.of(context).textTheme.displaySmall,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscured1,
                    focusNode: textFieldFocusNode,

                    controller: _passwordTextController,
                    onSaved: (newValue) => _passwordTextController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Password';
                      }
                      return null;
                    },
                    // decoration: InputDecoration(
                    //   labelText: "Enter Password",
                    //   filled: true,
                    //   floatingLabelBehavior: FloatingLabelBehavior.never,
                    //   border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(30.0),
                    //       borderSide: const BorderSide(
                    //           width: 0, style: BorderStyle.none)),
                    //   suffixIcon: Padding(
                    //     padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                    //     child: GestureDetector(
                    //       onTap: _toggleObscured1,
                    //       child: Icon(
                    //         _obscured1
                    //             ? Icons.visibility_off_rounded
                    //             : Icons.visibility_rounded,
                    //         size: 20,
                    //         color: IconButtonColor,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    decoration: CommonStyle.textFieldStyle(
                        labelTextStr: "Password",
                        hintTextStr: "Enter Password"),

                    // hintText: 'Name',
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: ElevatedButton(
                      onPressed: () async {
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
                          final uid = await FirebaseAuthentication()
                              .signinWithFirebase(_emailTextController.text,
                                  _passwordTextController.text);
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
                                        'Please Enter a Valid Email and Password.')));
                          }
                        } catch (e) {
                          Navigator.of(context)
                              .pop(); // Close the circular progress indicator
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
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

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: TextThemeColor)),
        TextButton(
          style: Theme.of(context).textButtonTheme.style,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return SignupScreen(
                  title: "signup",
                );
              },
            ));
          },
          child: const Text(
            'Sign Up',
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return TextButton(
      style: Theme.of(context).textButtonTheme.style,
      child: const Text(
        "Forgot Password?",
        textAlign: TextAlign.right,
      ),
      onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ResetPasswordScreen())),
    );
  }
}
