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
  String? code;
  // DevoteeModel? currentDevotee;

  int _currentIndex = 0;
  List<Widget> _pages = [];
  DevoteeModel? currentDevotee;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: FutureBuilder(
        future: GetDevoteeAPI().currentDevotee(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          _pages = [
            const DelegateCard(),
            const KnowMore(),
            if (snapshot.data["data"].isAllowedToScanPrasad == true)
              QrScannerScreen()
          ];
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Scaffold(
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
                  if (snapshot.data["data"].isAllowedToScanPrasad == true)
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.qr_code_scanner),
                      label: 'Scan',
                    ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
