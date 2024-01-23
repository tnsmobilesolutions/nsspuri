// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:sammilani_delegate/API/put_devotee.dart';
import 'package:sammilani_delegate/home_page/qr_scanner/scan_failed.dart';
import 'package:sammilani_delegate/home_page/qr_scanner/scan_success_screen.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({Key? key}) : super(key: key);

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? code;

  @override
  void initState() {
    super.initState();
    //_openQrScannerDialog();
  }

  Future<void> _openQrScannerDialog() async {
    qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
      context: context,
      onCode: (code) async {
        Map<String, dynamic> response = {};
        try {
          response = await PutDevoteeAPI().updatePrasad(code.toString());
        } on Exception catch (e) {
          print("Error while scanning: $e");
        }
        if (response["statusCode"] == 200) {
          setState(() {
            this.code = code;
          });
          if (context.mounted) {
            showDialog(
                context: context,
                builder: (context) {
                  return PrasadScanResultDialog(
                    response: response,
                    title: "Success !",
                    dialogColor: Colors.white,
                    buttonColor: Colors.deepOrange,
                    textColor: Colors.black,
                  );
                });
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return ScanSuccess(successMessage: response["data"]["error"]);
            // }));
          }
        } else {
          if (context.mounted) {
            showDialog(
                context: context,
                builder: (context) {
                  return PrasadScanResultDialog(
                    response: response,
                    title: "Failed !",
                    dialogColor: Colors.deepOrange,
                    buttonColor: Colors.white,
                    textColor: Colors.white,
                  );
                });
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return ScanFailedScreen(errorMessage: response["error"][0]);
            // }));
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppBarColor,
        title: const Text('QR Scanner'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _openQrScannerDialog,
          child: const Text('Scan QR Code'),
        ),
      ),
    );
  }
}

class PrasadScanResultDialog extends StatelessWidget {
  PrasadScanResultDialog({
    super.key,
    required this.response,
    required this.title,
    required this.dialogColor,
    required this.textColor,
    required this.buttonColor,
  });

  final Map<String, dynamic> response;
  String title;
  Color dialogColor;
  Color textColor;
  Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: dialogColor,
      title: Text(
        title,
        style: TextStyle(color: textColor, fontSize: 25),
        textAlign: TextAlign.center,
      ),
      content: Text(
        "${response["error"][0]}",
        style: TextStyle(color: textColor, fontSize: 20),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 45,
              width: 100,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(90)),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      return buttonColor;
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90)))),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                      color: dialogColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
