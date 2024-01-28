// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:sammilani_delegate/API/get_devotee.dart';
import 'package:sammilani_delegate/API/put_devotee.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';

class QrScannerScreen extends StatefulWidget {
  String? role;
  QrScannerScreen({
    Key? key,
    this.role,
  }) : super(key: key);

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? code;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _openQrScannerDialog() async {
    try {
      qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
        context: context,
        onCode: (code) async {
          try {
            final response = widget.role == "PrasadScanner"
                ? await PutDevoteeAPI().updatePrasad(code.toString())
                : await GetDevoteeAPI().securityScanner(code.toString());
            print("API scan response: $response");
            _handleScanResponse(code.toString(), response);
          } on Exception catch (e) {
            print("error while scanning: $e");
          }
        },
      );
    } on Exception catch (e) {
      print("Error while scanning: $e");
    }
  }

  void _handleScanResponse(String code, Map<String, dynamic> response) {
    try {
      if (response["statusCode"] == 200) {
        setState(() {
          this.code = code;
        });

        _showScanResultDialog(
            response, "Success !", Colors.green, Colors.white, Colors.white);
      } else {
        _showScanResultDialog(response, "Failed !", Colors.deepOrange,
            Colors.white, Colors.white);
      }
    } catch (e, stackTrace) {
      print("Error in _handleScanResponse: $e");
      print("Stack trace: $stackTrace");
    }
  }

  void _showScanResultDialog(Map<String, dynamic> response, String title,
      Color dialogColor, Color buttonColor, Color textColor) {
    if (context.mounted) {
      print("scan response: $response");
      showDialog(
        context: context,
        builder: (context) => PrasadScanResultDialog(
          response: response,
          role: widget.role,
          title: title,
          dialogColor: dialogColor,
          buttonColor: buttonColor,
          textColor: textColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppBarColor,
        title: const Text(
          'QR Scanner',
          style: TextStyle(color: Colors.white),
        ),
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
    this.role,
    required this.dialogColor,
    required this.textColor,
    required this.buttonColor,
  });

  final Map<String, dynamic> response;
  String? role;
  String title;
  Color dialogColor;
  Color textColor;
  Color buttonColor;

  Widget getContent() {
    try {
      if (role == "PrasadScanner") {
        if (response["statusCode"] == 200) {
          return Text(
            "${response["data"]["error"]}",
            style: TextStyle(color: textColor, fontSize: 20),
            textAlign: TextAlign.center,
          );
        } else {
          return Text(
            "${response["error"][0]}",
            style: TextStyle(color: textColor, fontSize: 20),
            textAlign: TextAlign.center,
          );
        }
      } else {
        if (response["statusCode"] == 200) {
          return Text(
            "${response["data"]}",
            style: TextStyle(color: textColor, fontSize: 20),
            textAlign: TextAlign.center,
          );
        } else {
          return Text(
            "Devotee not found !", //"${response["error"][0]}",
            style: TextStyle(color: textColor, fontSize: 20),
            textAlign: TextAlign.center,
          );
        }
      }
    } on Exception catch (e) {
      print("scan error: $e");
      return const ScaffoldMessenger(
        child: SnackBar(
          content: Text("Something went wrong !"),
        ),
      );
    }
  }
  // Widget getContent() {
  //   final bool isSuccess = response["statusCode"] == 200;
  //   final dynamic responseData =
  //       isSuccess ? response["data"] : response["error"][0];

  //   return Text(
  //     "$responseData",
  //     style: TextStyle(color: textColor, fontSize: 20),
  //     textAlign: TextAlign.center,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: dialogColor,
      title: Text(
        title,
        style: TextStyle(color: textColor, fontSize: 25),
        textAlign: TextAlign.center,
      ),
      content: getContent(),
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
