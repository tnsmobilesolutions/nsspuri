import 'package:flutter/material.dart';
import 'package:sammilani_delegate/API/post_devotee.dart';
import 'package:sammilani_delegate/authentication/devotee_details.dart';
import 'package:sammilani_delegate/firebase/firebase_auth_api.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:uuid/uuid.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 50, 12, 0),
          child: Column(
            children: [
              const Text(
                "Signup",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
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
                style: const TextStyle(fontSize: 20.0, color: Colors.black),

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
                obscureText: _obscured1,
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
                      onTap: _toggleObscured1,
                      child: Icon(
                        _obscured1
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                style: const TextStyle(fontSize: 20.0, color: Colors.black),
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
                      onTap: _toggleObscured2,
                      child: Icon(
                        _obscured2
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                style: const TextStyle(fontSize: 20.0, color: Colors.black),
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
                        return Colors.deepOrange;
                      }
                      return Colors.deepOrange;
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    try {
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
                            await PostDevoteeAPI().addDevotee(newDevotee);

                        if (response["statusCode"] == 200) {
                          // Show a circular progress indicator while navigating
                          // ignore: use_build_context_synchronously
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
                          Navigator.of(context)
                              .pop(); // Close the circular progress indicator
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return DevoteeDetailsPage(
                                  uid: uid,
                                  devoteeId: devoteeId,
                                );
                              },
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Signup failed')));
                          // Handle the case where the response status code is not 200
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Signup failed')));
                        // Handle the case where uid is null
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                      print(e);
                    }
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
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
