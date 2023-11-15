import 'package:flutter/material.dart';
import 'package:sammilani_delegate/API/get_devotee.dart';
import 'package:sammilani_delegate/authentication/signin_screen.dart';
import 'package:sammilani_delegate/firebase/firebase_auth_api.dart';

import 'package:sammilani_delegate/home_page/relative_delegate.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/screen/edit_devotee.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });
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
        backgroundColor: Color.fromARGB(255, 242, 247, 254),
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return EditDevoteeDetailsPage(
                        title: "add relatives", devotee: DevoteeModel());
                  },
                ));
              },
              icon: const Icon(Icons.add)),
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: IconButtonColor),
          backgroundColor: AppBarColor,
          elevation: .5,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pune Sammilani Delegate",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '${timeUntilSammilani.inDays} days to go (23 Feb 2024)',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: IconButtonColor),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(
                  //   height: 20,
                  // ),

                  FutureBuilder(
                    future: GetDevoteeAPI().devoteeWithRelatives(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        if (snapshot.data["statusCode"] == 200) {
                          print(snapshot.data);
                          return RelativeDelegate(devoteeData: snapshot.data);
                        } else {
                          return const Column(
                            children: [
                              Text("404 Error"),
                            ],
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
