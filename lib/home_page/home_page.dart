import 'package:flutter/material.dart';
import 'package:sammilani_delegate/API/get_devotee.dart';
import 'package:sammilani_delegate/authentication/signin_screen.dart';
import 'package:sammilani_delegate/firebase/firebase_auth_api.dart';
import 'package:sammilani_delegate/home_page/delegate_card.dart';
import 'package:sammilani_delegate/home_page/relative_delegate.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/screen/edit_devotee.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    required this.uid,
  });
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
        backgroundColor: ScaffoldBackgroundColor,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: IconButtonColor),
          backgroundColor: AppBarColor,
          elevation: .5,
          title: const Text(
            "Pune Sammilani Delegate",
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 1,
                        color: CardColor,
                        child: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(23),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Thank you for sharing your data. Please contact the following person for online payment for delegate.',
                                  style: TextStyle(
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Text('Suresh Bhai'),
                                    TextButton(
                                        onPressed: () => launchUrl(
                                            Uri.parse("tel://9502688244")),
                                        child: const Text("9502688244")),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 146,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 1,
                        color: CardColor,
                        child: InkWell(
                          onTap: () {},
                          child: Center(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text(
                                    '${timeUntilSammilani.inDays} ',
                                    style: const TextStyle(
                                        fontSize: 44,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                const Text('days to go')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 146,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 1,
                    color: CardColor,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return EditDevoteeDetailsPage(
                                devotee: DevoteeModel());
                          },
                        ));
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Get your relatives delegate',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              FutureBuilder(
                future: GetDevoteeAPI().loginDevotee(widget.uid),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.data["statusCode"] == 200) {
                      return Column(
                        children: [
                          DelegateCard(devoteeData: snapshot.data),
                        ],
                      );
                    } else {
                      return Column(
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
    );
  }
}
