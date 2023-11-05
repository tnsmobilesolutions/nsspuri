import 'package:flutter/material.dart';
import 'package:sammilani_delegate/API/get_devotee.dart';
import 'package:sammilani_delegate/API/post_devotee.dart';
import 'package:sammilani_delegate/authentication/devotee_details.dart';
import 'package:sammilani_delegate/firebase/firebase_auth_api.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';

import 'package:uuid/uuid.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key, required this.title}) : super(key: key);
  String title;
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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

  final _form = GlobalKey<FormState>();
  bool _isValid = false;

  void _saveForm() {
    setState(() {
      _isValid = _form.currentState!.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 70, 12, 0),
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
              Form(
                key: _form,
                child: TextFormField(
                  controller: emailController,
                  onSaved: (newValue) => emailController,
                  validator: (value) {
                    // Check if this field is empty
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }

                    // using regular expression
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return "Please enter a valid email address";
                    }

                    // the email is valid
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                  ),

                  // hintText: 'Name',
                ),
              ),
              const SizedBox(
                height: 30,
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
                obscureText: _obscured1,
                focusNode: textFieldFocusNode,
                decoration: InputDecoration(
                  labelText: "Password",
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none)),
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
                height: 22,
              ),
              TextFormField(
                controller: confirmPasswordController,
                onSaved: (newValue) => confirmPasswordController,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value != passwordController.text) {
                    return 'Confirm Pasword';
                  }
                  return null;
                },
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscured2,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none)),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                    child: GestureDetector(
                      onTap: _toggleObscured2,
                      child: Icon(
                        _obscured2
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        color: IconButtonColor,
                        size: 20,
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
                    try {
                      if (passwordController.text !=
                          confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Invalid Email or Password')));
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
                        await Future.delayed(
                            const Duration(seconds: 1)); // Simulating a delay
                        // ignore: use_build_context_synchronously

                        String? uid =
                            await FirebaseAuthentication().signupWithpassword(
                          emailController.text,
                          passwordController.text,
                        );
                        if (uid != null) {
                          String devoteeId = const Uuid().v1();
                          DevoteeModel newDevotee = DevoteeModel(
                            emailId: emailController.text,
                            uid: uid,
                            createdAt: DateTime.now().toString(),
                            updatedAt: DateTime.now().toString(),
                            devoteeId: devoteeId,
                          );

                          final response =
                              await PostDevoteeAPI().signupDevotee(newDevotee);
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
                                    devoteeId: devoteeId,
                                  );
                                },
                              ),
                            );
                          } else {
                            Navigator.of(context)
                                .pop(); // Close the circular progress indicator
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Signup failed')));
                            // Handle the case where the response status code is not 200
                          }
                        } else {
                          Navigator.of(context)
                              .pop(); // Close the circular progress indicator
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Signup failed')));
                          // Handle the case where uid is null
                        }
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                      print(e);
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
    );
  }
}
