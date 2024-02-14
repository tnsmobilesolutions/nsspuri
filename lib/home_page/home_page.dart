import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sammilani_delegate/API/get_devotee.dart';
import 'package:sammilani_delegate/home_page/delegate_card.dart';
import 'package:sammilani_delegate/home_page/know_more.dart';
import 'package:sammilani_delegate/home_page/qr_scanner/qrscanner_prasad.dart';
import 'package:sammilani_delegate/home_page/qr_scanner/qrscanner_security.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, this.index}) : super(key: key);

  int? index;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? code;
  DevoteeModel? currentDevotee;

  int _currentIndex = 0;
  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    getDevotee();
  }

  getDevotee() async {
    final devoteeData = await GetDevoteeAPI().currentDevotee();
    print("devotee data: $devoteeData");
    if (devoteeData != null && devoteeData.containsKey("data")
        // &&
        // devoteeData["data"] != null
        ) {
      setState(() {
        currentDevotee = devoteeData["data"];
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    _pages = [
      DelegateCard(index: widget.index),
      const KnowMore(),
      if (currentDevotee?.role == "PrasadScanner" ||
          currentDevotee?.role == "SecurityAndPrasadScan")
        QrScannerPrasad(role: currentDevotee?.role),
      if (currentDevotee?.role == "SecurityCheck" ||
          currentDevotee?.role == "SecurityAndPrasadScan")
        QrScannerSecurity(role: currentDevotee?.role),
    ];
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ScaffoldBackgroundColor,
        extendBodyBehindAppBar: false,
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          backgroundColor: const Color.fromARGB(255, 236, 236, 236),
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(Icons.card_membership),
              label: 'Delegate',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.more),
              label: 'Know More',
            ),
            if (currentDevotee?.role == "PrasadScanner" ||
                currentDevotee?.role == "SecurityAndPrasadScan")
              const BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_2_rounded),
                label: 'Prasad Scan',
              ),
            if (currentDevotee?.role == "SecurityCheck" ||
                currentDevotee?.role == "SecurityAndPrasadScan")
              const BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_2_rounded),
                label: 'Security Scan',
              ),
          ],
        ),
      ),
    );
  }
}
