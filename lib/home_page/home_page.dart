import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:sammilani_delegate/home_page/delegate_card.dart';
import 'package:sammilani_delegate/home_page/know_more.dart';
import 'package:sammilani_delegate/home_page/qr_scanner.dart/qrcode_scanner.dart';
import 'package:sammilani_delegate/home_page/qr_scanner.dart/scan_success_screen.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? code;

  final List<Widget> _pages = [
    const DelegateCard(), // Remove const here
    const KnowMore(),
    const ScanSuccess()
  ];

  @override
  Widget build(BuildContext context) {
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
            BottomNavigationBarItem(
              icon: Icon(Icons.card_membership),
              label: 'Delegate',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more),
              label: 'Know More',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: () {
                    _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                      context: context,
                      onCode: (code) {
                        setState(() {
                          this.code = code;
                        });
                      },
                    );
                  },
                  child: Icon(Icons.qr_code_scanner)),
              label: 'Scan',
            ),
          ],
        ),
      ),
    );
  }
}
