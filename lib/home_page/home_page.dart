import 'package:flutter/material.dart';
import 'package:sammilani_delegate/authentication/signin_screen.dart';
import 'package:sammilani_delegate/home_page/delegate_card.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';

class HomePage extends StatefulWidget {
   HomePage({super.key, this.devotee});
  DevoteeModel? devotee;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/white-texture.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          flexibleSpace: Image(
            image: AssetImage('assets/images/white-texture.jpeg'),
            fit: BoxFit.cover,
          ),
          leading: const Icon(
            Icons.menu,
            color: Colors.deepOrange,
          ),
          title: const Text(
            "Home",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout, color: Colors.deepOrange),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
            ),
          ],
        ),
        body: Center(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/white-texture.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: const DelegateCard(),
        )),
      ),
    );
  }
}
