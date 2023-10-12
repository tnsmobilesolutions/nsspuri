
import 'package:flutter/material.dart';
import 'package:sammilani_delegate/reusable_widgets/reusable_widgets.dart';
import 'package:sammilani_delegate/utilities/color_utilities.dart';

import 'reset_password.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/logo1.png"),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter UserName", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, true,
                    _passwordTextController),
                const SizedBox(
                  height: 21,
                ),
           ElevatedButton(
            onPressed: () {
              
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal),
             ),
            child: const Text('Sign in'), ),

                forgetPassword(context),
                // firebaseUIButton(context, "Sign In", () {
                //   FirebaseAuth.instance
                //       .signInWithEmailAndPassword(
                //           email: _emailTextController.text,
                //           password: _passwordTextController.text)
                //       .then((value) {
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (context) => HomeScreen()));
                //   }).onError((error, stackTrace) {
                //     print("Error ${error.toString()}");
                //   });
                // }),
                signUpOption()
              ],
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
            style: TextStyle(color: Colors.white70)),
       SizedBox(
        
         width: 80
         ,
         child: SizedBox(
           child: TextButton(
               onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return  AlertDialog(
                      backgroundColor: Colors.white,
          
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: const EdgeInsets.only(top: 10),
            content:  Stack(
  
    alignment: Alignment.center,
    children: <Widget>[
      SizedBox(
        width: MediaQuery.of(context).size.width/1.2,
       height: MediaQuery.of(context).size.height/3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const Text("Signup by:",style:TextStyle(
            color: Colors.red,
              fontWeight: FontWeight.bold,fontSize: 25,
            ) ,
            ),
            const SizedBox(
              height: 30,
            ),
             ElevatedButton(onPressed: (){
              
             }, child: const Text('Email',style:TextStyle(
              fontWeight: FontWeight.bold,fontSize: 30,
            ) ,)),
            const SizedBox(
              height: 10,
            ),
              ElevatedButton(onPressed: (){}, child: const Text('Phone',style:TextStyle(
              fontWeight: FontWeight.bold,fontSize: 30,
            ) ,)),
             
          ],
        ),
      ),
     Positioned(
              top: -5,
              right: 0.0,
              child: FloatingActionButton(
                child: const Icon(Icons.close),
                onPressed: (){
                Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
                backgroundColor: Colors.red,
                mini: true,
                elevation: 5.0,
              ),
            ),
    ],
                    ));
                  },
  
);
               },
               child: const Text('Sign Up'),
             ),
         ),
       )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => const ResetPassword())),
      ),
    );
  }
}
