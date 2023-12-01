import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';

class ScanFailedScreen extends StatefulWidget {
  ScanFailedScreen({super.key, this.errorMessage});
  String? errorMessage;
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
          height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.width,
          color: const Color.fromARGB(255, 241, 66, 64),
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
                        left: 20,
                        top: 20,
                        child: Icon(
                          Icons.close,
                          size: 80,
                          color: Color.fromARGB(255, 241, 66, 64),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    widget.errorMessage.toString(),
                    style: const TextStyle(fontSize: 35, color: Colors.white),
                  ),
                )),
                const SizedBox(
                  height: 141,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(0)),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.green;
                        }
                        return ButtonColor;
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                    // Within the `FirstRoute` widget
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'DONE',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
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
