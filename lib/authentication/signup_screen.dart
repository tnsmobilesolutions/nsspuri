
import 'package:flutter/material.dart';
import 'package:sammilani_delegate/utilities/color_utilities.dart';

import '../reusable_widgets/reusable_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
     TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _AddressTextController = TextEditingController();
     TextEditingController _phoneNumberTextController = TextEditingController();
        TextEditingController _sanghaNameTextController = TextEditingController();
           TextEditingController _genderTextController = TextEditingController();
              TextEditingController _bloodGroupTextController = TextEditingController();
              


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColor("CB2B93"),
            hexStringToColor("9546C4"),
            hexStringToColor("5E61F4")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.fromLTRB(20, 100, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Devotee Name", Icons.person_outline, false,
                    _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email Id", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outlined, true,
                    _passwordTextController),
                      const SizedBox(
                  height: 20,
                ),
                    
                 reusableTextField("Address", Icons.person_outline, false,
                    _AddressTextController),
                const SizedBox(
                  height: 20,),
                   reusableTextField("Phone Number", Icons.person_outline, false,
                    _phoneNumberTextController),
                const SizedBox(
                  height: 20,),
                   reusableTextField("Sangha Name", Icons.person_outline, false,
                    _sanghaNameTextController),
                const SizedBox(
                  height: 20,),
                   reusableTextField("Gender", Icons.person_outline, false,
                    _genderTextController),
                const SizedBox(
                  height: 20,),
                   reusableTextField("Blood Group", Icons.person_outline, false,
                    _bloodGroupTextController),
                const SizedBox(
                  height: 20,)
                // firebaseUIButton(context, "Sign Up", () {
                //   FirebaseAuth.instance
                //       .createUserWithEmailAndPassword(
                //           email: _emailTextController.text,
                //           password: _passwordTextController.text)
                //       .then((value) {
                //     print("Created New Account");
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (context) => HomeScreen()));
                //   }).onError((error, stackTrace) {
                //     print("Error ${error.toString()}");
                //   });
                // })
              ],
            ),
          ))),
    );
  }
}
