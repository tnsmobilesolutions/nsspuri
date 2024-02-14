// ignore_for_file: avoid_print, must_be_immutable

import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:sammilani_delegate/API/get_devotee.dart';
import 'package:sammilani_delegate/firebase/firebase_remote_config.dart';
import 'package:sammilani_delegate/home_page/qr_scanner/scan_failed.dart';
import 'package:sammilani_delegate/home_page/qr_scanner/scan_success.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';

class QrScannerSecurity extends StatefulWidget {
  QrScannerSecurity({
    Key? key,
    this.role,
  }) : super(key: key);

  String? role;

  @override
  State<QrScannerSecurity> createState() => _QrScannerSecurityState();
}

class _QrScannerSecurityState extends State<QrScannerSecurity> {
  String? code;
  String offlinePrasadKey = "offline_prasad";
  final qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  int scannerCloseDuration = RemoteConfigHelper().getScannerCloseDuration;
  TextEditingController devoteeInfoController = TextEditingController();
  late String date, time;
  String prasadTiming = "";
  int totalCount = 0;

  @override
  void initState() {
    super.initState();
  }

  _openQrScannerDialog() async {
    try {
      qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
        context: context,
        onCode: (code) async {
          try {
            final response =
                await GetDevoteeAPI().securityScanner(code.toString());
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

  void _handleScanResponse(String code, Map<String, dynamic> response) async {
    try {
      if (response["statusCode"] == 200) {
        setState(() {
          this.code = code;
        });
        print("scan code : $response");
        String status = response["data"]["status"];
        String devoteeName = "";
        String devoteeCode = "";
        String errorMessage = "";
        DevoteeModel devotee;

        if (response["data"]["devoteeData"] != null) {
          devotee = DevoteeModel.fromMap(response["data"]["devoteeData"]);
          devoteeName = devotee.name.toString();
          devoteeCode = devotee.devoteeCode.toString();
        }

        if (status == "Success") {
          print("scan code : $devoteeName");
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ScanSuccess(
                      devoteeName: devoteeName,
                      devoteeCode: devoteeCode,
                      closeDuration: scannerCloseDuration,
                    )),
          );
          if (result != null && context.mounted) {
            print("success back");
            _openQrScannerDialog();
          }
        } else if (status == "Failure") {
          print("scan code : $response");
          errorMessage = response['data']["error"]["message"];
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ScanFailed(
                      devoteeName: devoteeName,
                      devoteeCode: devoteeCode,
                      errorMessage: errorMessage,
                      closeDuration: scannerCloseDuration,
                    )),
          );
          if (result != null && context.mounted) {
            print("failure back");
            _openQrScannerDialog();
          }
        }
      } else {
        print("invalid scan");
      }
    } catch (e, stackTrace) {
      print("Error in _handleScanResponse: $e");
      print("Stack trace: $stackTrace");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppBarColor,
        title: const Text(
          'Security Scanner',
          style: TextStyle(color: Colors.white),
        ),
        leading: const SizedBox(),
      ),
      body: ConnectivityWidget(
          onlineCallback: () async {},
          offlineCallback: () async {},
          initialLoadingWidget: const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context, isOnline) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90)),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              return Colors.deepOrange;
                            }),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(90)))),
                        onPressed: _openQrScannerDialog,
                        child: const Text(
                          'Scan QR Code',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
