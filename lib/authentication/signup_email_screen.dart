// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sammilani_delegate/API/get_devotee.dart';
import 'package:sammilani_delegate/API/post_devotee.dart';
import 'package:sammilani_delegate/authentication/devotee_details.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/reusable_widgets/common_style.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';

import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key, required this.title}) : super(key: key);
  String title;
  @override
  // ignore: library_private_types_in_public_api
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final textFieldFocusNode = FocusNode();
  bool _obscured1 = true;
  bool _obscured2 = true;

  void _toggleObscured1() {
    setState(() {
      _obscured1 = !_obscured1;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  void _toggleObscured2() {
    setState(() {
      _obscured2 = !_obscured2;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ScaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 70, 12, 0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  "Signup",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w300,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  controller: emailController,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(
                        RegExp(r'\s')), // Deny whitespace
                  ],
                  onSaved: (newValue) =>
                      emailController.text = newValue!.trim(),
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
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.always,

                  // style: Theme.of(context).textTheme.displaySmall,
                  controller: passwordController,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(
                        RegExp(r'\s')), // Deny whitespace
                  ],
                  onSaved: (newValue) => passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password';
                    } else if (value.length < 6) {
                      return "Password must be at least 6 characters long !";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _obscured1,
                  focusNode: textFieldFocusNode,
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
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none),
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
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    autovalidateMode: AutovalidateMode.always,

                    // style: Theme.of(context).textTheme.displaySmall,
                    controller: confirmPasswordController,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(
                          RegExp(r'\s')), // Deny whitespace
                    ],
                    onSaved: (newValue) => confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please cofirm password';
                      } else if (value != passwordController.text) {
                        return "Confirm password !";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscured2,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12),
                      labelText: "Confirm Password",
                      labelStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400),
                      hintText: "Confirm Password",
                      hintStyle:
                          const TextStyle(fontSize: 16, color: Colors.grey),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 190, 190, 190)
                          .withOpacity(0.3),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.0),
                        borderSide:
                            const BorderSide(width: 0, style: BorderStyle.none),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                        child: GestureDetector(
                          onTap: _toggleObscured2,
                          child: Icon(
                            _obscured2
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            size: 20,
                            color: IconButtonColor,
                          ),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(90)),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return ButtonColor;
                        }
                        return ButtonColor;
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          if (passwordController.text.trim() !=
                              confirmPasswordController.text.trim()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Invalid Email or Password')));
                          } else {
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
                            await Future.delayed(const Duration(
                                seconds: 1)); // Simulating a delay
                            // ignore: use_build_context_synchronously
                            String? uid;
                            // try {
                            //   uid = await FirebaseAuthentication()
                            //       .signupWithpassword(
                            //     emailController.text.trim(),
                            //     passwordController.text.trim(),
                            //   );
                            // } on Exception catch (e) {
                            // if (context.mounted) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       SnackBar(content: Text(e.toString())));
                            // }
                            // }
                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  )
                                  .then((value) => uid = value.user?.uid);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "The password provided is too weak !")));
                                }
                              } else if (e.code == 'email-already-in-use') {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Email already exists !")));
                                }
                              }
                            } catch (e) {
                              print(e);
                            }

                            if (uid != null) {
                              String devoteeId = const Uuid().v1();
                              DevoteeModel newDevotee = DevoteeModel(
                                  emailId: emailController.text.trim(),
                                  uid: uid,
                                  devoteeId: devoteeId,
                                  createdById: devoteeId,
                                  isAdmin: false,
                                  role: "User",
                                  isAllowedToScanPrasad: false,
                                  status: "dataSubmitted");

                              final response = await PostDevoteeAPI()
                                  .signupDevotee(newDevotee);
                              await GetDevoteeAPI()
                                  .loginDevotee(uid.toString());
                              print("devotee response : $response");
                              if (response["statusCode"] == 200) {
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return DevoteeDetailsPage(
                                          devotee: DevoteeModel.fromMap(
                                              response["data"]),
                                        );
                                      },
                                    ),
                                  );
                                }
                              } else {
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Signup failed')));
                                }
                              }
                            } else {
                              Navigator.of(context).pop();
                              // if (context.mounted) {

                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //       const SnackBar(
                              //           content: Text('Signup failed !')));
                              // }
                            }
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          }
                          print(e);
                        }
                      }
                    },
                    child: const Text(
                      "Next",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
