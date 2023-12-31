import 'package:flutter/material.dart';
import 'package:sammilani_delegate/API/get_devotee.dart';
import 'package:sammilani_delegate/authentication/signin_screen.dart';
import 'package:sammilani_delegate/firebase/firebase_auth_api.dart';
import 'package:sammilani_delegate/firebase/firebase_remote_config.dart';

import 'package:sammilani_delegate/home_page/relative_delegate.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/screen/edit_devotee.dart';
import 'package:sammilani_delegate/screen/pranami_info_screen.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DelegateCard extends StatefulWidget {
  const DelegateCard({super.key});

  @override
  State<DelegateCard> createState() => _DelegateCardState();
}

DateTime sammilaniDate = DateTime(2024, 2, 23);
int _currentIndex = 0;

class _DelegateCardState extends State<DelegateCard> {
  Color getColorByDevotee(DevoteeModel devotee) {
    if (devotee.isGuest == true) {
      return Colors.yellow;
    } else if (devotee.isOrganizer == true) {
      return Colors.red;
    } else if (devotee.isSpeciallyAbled == true ||
        calculateAge(DateTime.parse(devotee.dob ?? "2000-01-01")) >= 60) {
      return Colors.purple;
    } else if (calculateAge(DateTime.parse(devotee.dob ?? "2000-01-01")) <=
        18) {
      return Colors.green;
    } else if (devotee.gender == "Male") {
      return Colors.blue;
    } else if (devotee.gender == "Female") {
      return Colors.pink;
    } else {
      return Colors.blue;
    }
  }

  int calculateAge(DateTime dob) {
    DateTime now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    Duration timeUntilSammilani = sammilaniDate.difference(DateTime.now());
    return Scaffold(
        backgroundColor: ScaffoldBackgroundColor,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditDevoteeDetailsPage(
                    title: "add relatives",
                    devotee: DevoteeModel(),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: IconButtonColor),
          backgroundColor: AppBarColor,
          elevation: .5,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pune Sammilani",
              ),
              Text(
                '${timeUntilSammilani.inDays} days to go (23, 24, 25 Feb 2024)',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
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
                  MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PranamiInfoScreen(),
                          ),
                        );
                      },
                      child: Text('Payment Info'),
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
                                      borderRadius:
                                          BorderRadius.circular(40)))),
                    ),
                  ),
                ),

                FutureBuilder(
                  future: GetDevoteeAPI().devoteeWithRelatives(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (snapshot.data["statusCode"] == 200) {
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
                // const SizedBox(
                //   height: 20,
                // ),
              ],
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
          child: FloatingActionButton(
            backgroundColor: Colors.deepOrange,
            elevation: 8,
            onPressed: () {
              launchUrlString("tel:+91${RemoteConfigHelper().helpContactNo}");
            },
            child: const Text('Help!'),
          ),
        ));
  }
}