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
  DateTime sammilaniDate = DateTime(2024, 2, 23);
  int selectedPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    Duration timeUntilSammilani = sammilaniDate.difference(DateTime.now());
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: Colors.deepOrange),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Pune Sammilani Delegate",
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
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 10,
              color: Colors.amber,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  '${timeUntilSammilani.inDays} days to go for Sammilani',
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: GetDevoteeAPI().loginDevotee(widget.uid),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.data["statusCode"] == 200) {
                    return Center(
                        child: DelegateCard(devoteeData: snapshot.data));
                  } else {
                    return const Center(
                      child: Text("404 Error"),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
