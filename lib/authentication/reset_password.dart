import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sammilani_delegate/firebase/exception_handler.dart';
import 'package:sammilani_delegate/reusable_widgets/common_style.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String id = 'reset_password';
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  static final auth = FirebaseAuth.instance;
  static late AuthStatus _status;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<AuthStatus> resetPassword({required String email}) async {
    await auth
        .sendPasswordResetEmail(email: email)
        .then((value) => _status = AuthStatus.successful)
        .catchError(
            (e) => _status = AuthExceptionHandler.handleAuthException(e));

    return _status;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 227),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          color: CardColor,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 50.0, bottom: 25.0),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close),
                  ),
                  const SizedBox(height: 70),
                  Text("Forgot Password",
                      style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(height: 16),
                  Text(
                      'Please enter your email address to recover your password.',
                      style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 40),
                  const Text(
                    'Email address',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.always,
                      controller: _emailController,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(
                            RegExp(r'\s')), // Deny whitespace
                      ],
                      onSaved: (newValue) =>
                          _emailController.text = newValue!.trim(),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter your Email';
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
                  ),
                  const SizedBox(height: 16),
                  const Expanded(child: SizedBox()),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_key.currentState!.validate()) {
                            final _status = await resetPassword(
                                email: _emailController.text.trim());

                            if (!RegExp(r'\S+@\S+\.\S+')
                                .hasMatch(_emailController.text.trim())) {
                              // Show a SnackBar with an error message if the email is not valid.
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Invalid Username')));
                            }
                            if (_status == AuthStatus.successful) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content:
                                    Text('Reset Password link sent to Email'),
                              ));
                              //your logic
                            }
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                          print(e);
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
                            borderRadius: BorderRadius.circular(90),
                          ),
                        ),
                      ),
                      child: Text(
                        'Recover Password ',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
