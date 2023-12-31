import 'package:flutter/material.dart';
import 'package:sammilani_delegate/API/get_devotee.dart';
import 'package:sammilani_delegate/API/post_devotee.dart';
import 'package:sammilani_delegate/authentication/devotee_details.dart';
import 'package:sammilani_delegate/firebase/firebase_auth_api.dart';
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
                  // style: Theme.of(context).textTheme.displaySmall,
                  controller: emailController,
                  onSaved: (newValue) => emailController,
                  validator: (value) {
                    // Check if this field is empty
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }

                    // using regular expression
                    if (!RegExp(
                      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
                    ).hasMatch(value)) {
                      return "Please enter a valid email address";
                    }

                    // the email is valid
                    return null;
                  },
                  decoration: CommonStyle.textFieldStyle(
                    labelTextStr: "Email",
                    hintTextStr: "Enter Email",
                  ),

                  // hintText: 'Name',
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  // style: Theme.of(context).textTheme.displaySmall,
                  controller: passwordController,
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
                    hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
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
                    // style: Theme.of(context).textTheme.displaySmall,
                    controller: confirmPasswordController,
                    onSaved: (newValue) => confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      } else if (value != passwordController.text) {
                        return "Confirm password !";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscured2,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12),
                      labelText: "Password",
                      labelStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400),
                      hintText: "Password",
                      hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
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
                          if (passwordController.text !=
                              confirmPasswordController.text) {
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

                            String? uid = await FirebaseAuthentication()
                                .signupWithpassword(
                              emailController.text,
                              passwordController.text,
                            );
                            if (uid != null) {
                              String devoteeId = const Uuid().v1();
                              DevoteeModel newDevotee = DevoteeModel(
                                  emailId: emailController.text,
                                  uid: uid,
                                  devoteeId: devoteeId,
                                  createdById: devoteeId,
                                  isAdmin: false,
                                  isAllowedToScanPrasad: false,
                                  status: "dataSubmitted");

                              final response = await PostDevoteeAPI()
                                  .signupDevotee(newDevotee);
                              await GetDevoteeAPI().loginDevotee(uid);
                              if (response["statusCode"] == 200) {
                                // Show a circular progress indicator while navigating
                                // ignore: use_build_context_synchronously
                                Navigator.of(context)
                                    .pop(); // Close the circular progress indicator
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return DevoteeDetailsPage(
                                        devotee: newDevotee,
                                      );
                                    },
                                  ),
                                );
                              } else {
                                Navigator.of(context)
                                    .pop(); // Close the circular progress indicator
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Signup failed')));
                                // Handle the case where the response status code is not 200
                              }
                            } else {
                              Navigator.of(context)
                                  .pop(); // Close the circular progress indicator
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Signup failed')));
                              // Handle the case where uid is null
                            }
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
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
