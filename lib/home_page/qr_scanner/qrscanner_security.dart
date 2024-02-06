// ignore_for_file: avoid_print, must_be_immutable

import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:sammilani_delegate/API/get_devotee.dart';
import 'package:sammilani_delegate/API/put_devotee.dart';
import 'package:sammilani_delegate/home_page/qr_scanner/scan_failed.dart';
import 'package:sammilani_delegate/home_page/qr_scanner/scan_success_screen.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/model/offline_prasad.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late int scannerCloseDuration;
  TextEditingController devoteeInfoController = TextEditingController();
  late String date, time;
  String prasadTiming = "";
  int totalCount = 0;
  List<OfflinePrasad> offlinePrasads = [];
  final _offlinePrasadFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    time = DateFormat("HH:mm").format(DateTime.now());
    _initialize();
    fetchPrasadInfo();
  }

  fetchPrasadInfo() async {
    Map<String, dynamic>? response =
        await GetDevoteeAPI().prasdCountNow(date, time);
    if (response != null && response["data"] != null) {
      print("response: $response");
      setState(() {
        totalCount = response["data"]["count"];
        prasadTiming = response["data"]["timing"];
        date = response["data"]["date"];
      });
    }
  }

  Future<void> _initialize() async {
    await fetchScannerCloseDuration(context);
  }

  fetchScannerCloseDuration(context) async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(hours: 24),
        minimumFetchInterval: Duration.zero,
      ));
      remoteConfig.getInt('scanner_auto_close_duration');
      await remoteConfig.fetchAndActivate();
      int closeDuration = remoteConfig.getInt('scanner_auto_close_duration');
      setState(() {
        scannerCloseDuration = closeDuration;
      });
    } on PlatformException catch (exception) {
      print(exception);
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
      print("exception===>$exception");
    }
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
        String errorMessage = "";
        DevoteeModel devotee;

        if (response["data"]["devoteeData"] != null) {
          devotee = DevoteeModel.fromMap(response["data"]["devoteeData"]);
          devoteeName = devotee.name.toString();
        }

        if (status == "Success") {
          print("scan code : $devoteeName");
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ScanSuccess(
                      devoteeName: devoteeName,
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
                      errorMessage: errorMessage,
                      closeDuration: scannerCloseDuration,
                    )),
          );
          if (result != null && context.mounted) {
            print("failure back");
            _openQrScannerDialog();
          }
        }

        // _showScanResultDialog(
        //     response, "Success !", Colors.green, Colors.white, Colors.white);
      } else {
        print("invalid scan");
      }
    } catch (e, stackTrace) {
      print("Error in _handleScanResponse: $e");
      print("Stack trace: $stackTrace");
    }
  }

  String formatNumberWithCommas(int input) {
    final formatter = NumberFormat("#,###");
    String formattedNumber = formatter.format(input);

    return formattedNumber;
  }

  // static Future<void> saveListToPrefs(
  //     String key, List<OfflinePrasad> prasadList) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final List<String> jsonList =
  //       prasadList.map((prasad) => prasad.toJson()).toList();
  //   prefs.setStringList(key, jsonList);
  // }

  //  static Future<void> saveToPrefs(String key, OfflinePrasad prasad) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString(key, prasad.toJson());
  // }

  Future<void> saveToPrefs(String key, OfflinePrasad prasad) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> existingList = prefs.getStringList(key) != null ||
            (prefs.getStringList(key)?.isNotEmpty == true)
        ? (prefs.getStringList(key) ?? [])
        : [];
    existingList.add(prasad.toJson());
    prefs.setStringList(key, existingList);
  }

  static Future<List<OfflinePrasad>> loadListFromPrefs(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonStringList = prefs.getStringList(key);

    if (jsonStringList != null) {
      return jsonStringList
          .map((jsonString) => OfflinePrasad.fromJson(jsonString))
          .toList();
    }

    return [];
  }

  List<int> convertStringToList(String devoteeCodes) {
    List<String> devoteeCodeList = devoteeCodes.split(',');
    List<int> intCodeList =
        devoteeCodeList.map((code) => int.parse(code)).toList();
    return intCodeList;
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
