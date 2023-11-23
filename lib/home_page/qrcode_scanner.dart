import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({super.key});

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? code;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppBarColor,
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                  context: context,
                  onCode: (code) {
                    setState(() {
                      this.code = code;
                    });
                  });
            },
            child: Text(code ?? "Click me")),
      ),
    );
  }
}
