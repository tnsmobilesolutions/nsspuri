import 'package:flutter/material.dart';
import 'package:sammilani_delegate/API/get_devotee.dart';
import 'package:sammilani_delegate/home_page/delegate_card.dart';
import 'package:sammilani_delegate/home_page/know_more.dart';
import 'package:sammilani_delegate/home_page/qr_scanner/qrcode_scanner.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String? code;
  DevoteeModel? currentDevotee;

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
        //initializePages();
      });
    } else {}
  }

  // void initializePages() {
  //   setState(() {
  //     _pages = [
  //       const DelegateCard(),
  //       const KnowMore(),
  //       if (currentDevotee?.isAllowedToScanPrasad == true)
  //         const QrScannerScreen(),
  //     ];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    _pages = [
      const DelegateCard(),
      const KnowMore(),
      if (currentDevotee?.isAllowedToScanPrasad == true)
        const QrScannerScreen(),
    ];
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ScaffoldBackgroundColor,
        extendBodyBehindAppBar: false,
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.deepOrange,
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
            if (currentDevotee?.isAllowedToScanPrasad == true)
              const BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_scanner),
                label: 'Scan',
              ),
          ],
        ),
      ),
    );
  }
}
