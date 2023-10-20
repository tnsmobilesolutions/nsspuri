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
  int selectedPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
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
        bottomNavigationBar: NavigationBar(
            selectedIndex: selectedPageIndex,
            onDestinationSelected: (int index) {
              setState(() {
                selectedPageIndex = index;
              });
            },
            destinations: const <NavigationDestination>[
              NavigationDestination(
                selectedIcon: Icon(Icons.person),
                icon: Icon(Icons.person_outline),
                label: 'Learn',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.engineering),
                icon: Icon(Icons.engineering_outlined),
                label: 'Relearn',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.bookmark),
                icon: Icon(Icons.bookmark_border),
                label: 'Unlearn',
              )
            ]));
  }
}
