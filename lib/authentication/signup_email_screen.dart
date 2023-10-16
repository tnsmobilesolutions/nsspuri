
import 'package:flutter/material.dart';
import 'package:sammilani_delegate/authentication/login/devotee_details.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container
      (

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
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold,color: Colors.black),
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
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
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
                       decoration: InputDecoration(
      
      labelText: " Password",
      labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.grey.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
          
              ),
                
              const SizedBox(
                height: 21,
              ),
              TextFormField(
                controller: confirmPasswordController,
                onSaved: (newValue) => confirmPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ' Confirm Password';
                  }
                  return null;
                },
                       decoration: InputDecoration(
      
      labelText: " Confirm Password",
      labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.grey.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
          
              ),
                
              const SizedBox(
                height: 21,
              ),
              ElevatedButton(
               onPressed: () async{
                String? uid =  await FirebaseAuthentication().signupWithpassword(emailController.text, passwordController.text);
                if (uid != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DevoteeDetailsPage();
                  },));
                }
               },
               
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                  textStyle: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.normal),
                ),
                child: const Text('Next'),
              ),
           
           
            ],
          ),
        ),
      ),
    );
  }

 

 
}