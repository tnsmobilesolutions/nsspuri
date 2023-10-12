import 'package:flutter/material.dart';

  


class FirstScreen extends StatefulWidget {
  FirstScreen({super.key });
   

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
   
      return Scaffold(
       
        
        body: SafeArea(
          
              child: SingleChildScrollView(
        child: SizedBox(
          
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text ("Sign up", style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),),
                      const SizedBox(height: 20,),
                      Text("Create an Account",style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                      ),),
                      const SizedBox(height: 30,)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40
                    ),
                    child: Column(
                      children: [
                        makeInput(label: "Email"),
                        makeInput(label: "Password",obsureText: true),
                        makeInput(label: "Confirm Pasword",obsureText: true)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: const EdgeInsets.only(top: 3,left: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: const Border(
                              bottom: BorderSide(color: Colors.black),
                              top: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black)
                          )
                      ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height:60,
                        onPressed: () {


                        } ,
                        color: Colors.purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: const Text("Next",style: TextStyle(
                          fontWeight: FontWeight.bold,fontSize: 22,
                          color: Colors.white,
        
                        ),),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? "),
                      Text("Login",style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18
                      ),),
                    ],
                  )
                ],
        
              ),
            ],
          ),
        ),
              ),
            ),
     );
     
   } );
  }

Widget makeInput({label,obsureText = false}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,style:const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87
      ),),
      const SizedBox(height: 5,),
      TextField(
        obscureText: obsureText,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)
          ),
        ),
      ),
      const SizedBox(height: 30,)

    ],
  );
} 
}   