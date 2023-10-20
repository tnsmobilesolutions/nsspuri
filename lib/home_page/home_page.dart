import 'package:flutter/material.dart';
import 'package:sammilani_delegate/API/get_devotee.dart';
import 'package:sammilani_delegate/authentication/signin_screen.dart';
import 'package:sammilani_delegate/firebase/firebase_auth_api.dart';
import 'package:sammilani_delegate/home_page/delegate_card.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({super.key, required this.uid});
  String uid;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.transparent,
                        backgroundImage:
                            AssetImage('assets/images/nsslogo.png'),
                      ),
                      const Text(
                        'Welcome',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Sangha'),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.deepOrange),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.deepOrange),
            onPressed: () {
              FirebaseAuthentication().signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignInScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: GetDevoteeAPI().loginDevotee(widget.uid),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data["statusCode"] == 200) {
              return Center(child: DelegateCard(devoteeData: snapshot.data));
            } else {
              return const Center(
                child: Text("404 Error"),
              );
            }
          }
        },
      ),
    );
  }
}
