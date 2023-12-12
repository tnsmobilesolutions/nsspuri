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
        Map<String, dynamic> response =
            await PutDevoteeAPI().updatePrasad(code.toString());
        if (response["statusCode"] == 200) {
          setState(() {
            this.code = code;
          });
          if (context.mounted) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ScanSuccess(successMessage: response["data"]["error"]);
            }));
          }
        } else {
          if (context.mounted) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ScanFailedScreen(errorMessage: response["error"][0]);
            }));
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
