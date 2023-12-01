// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:sammilani_delegate/API/put_devotee.dart';
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
        //print("response : $response");
        //   if (response["statusCode"] == 200) {
        //     print("response : $response");
        //     setState(() {
        //       this.code = code;
        //     });
        //     if (context.mounted) {
        //       showDialog(
        //         context: context,
        //         builder: (context) {
        //           return const AlertDialog(
        //             title: Text(
        //               "Success",
        //               style: TextStyle(
        //                 color: Colors.green,
        //                 fontSize: 15,
        //               ),
        //             ),
        //           );
        //         },
        //       );
        //     }
        //   } else {
        //     if (context.mounted) {
        //       showDialog(
        //         context: context,
        //         builder: (context) {
        //           return const AlertDialog(
        //             title: Text(
        //               "Something went wrong !",
        //               style: TextStyle(
        //                 color: Colors.red,
        //                 fontSize: 15,
        //               ),
        //             ),
        //           );
        //         },
        //       );
        //     }
        //   }
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (code != null)
              Text(
                'Scanned Code: $code',
                style: const TextStyle(fontSize: 18),
              )
            else
              ElevatedButton(
                onPressed: _openQrScannerDialog,
                child: const Text('Scan QR Code'),
              ),
          ],
        ),
      ),
    );
  }
}
