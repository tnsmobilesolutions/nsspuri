import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';

class ScanFailedScreen extends StatefulWidget {
  const ScanFailedScreen({super.key});

  @override
  State<ScanFailedScreen> createState() => _ScanFailedScreenState();
}

class _ScanFailedScreenState extends State<ScanFailedScreen> {
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? code;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ScaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100, left: 15, right: 15),
        child: Container(
          height: MediaQuery.of(context).size.height / 1.7,
          width: MediaQuery.of(context).size.width,
          color: Color.fromARGB(255, 241, 66, 64),
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 60,
                      ),
                      Positioned(
                        left: 25,
                        top: 20,
                        child: Icon(
                          Icons.cancel,
                          size: 80,
                            color: Color.fromARGB(255, 241, 66, 64),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                const Center(
                    child: Text(
                  'Failed!',
                  style: TextStyle(fontSize: 35, color: Colors.white),
                )),
                const SizedBox(
                  height: 120,
                ),
                Divider(
                  thickness: 2,
                  color: Colors.white.withOpacity(.5),
                ),
                TextButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                   Color.fromARGB(255, 241, 66, 64),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'OK',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
