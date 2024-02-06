// ignore_for_file: avoid_print, must_be_immutable

import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:sammilani_delegate/API/get_devotee.dart';
import 'package:sammilani_delegate/API/put_devotee.dart';
import 'package:sammilani_delegate/firebase/firebase_remote_config.dart';
import 'package:sammilani_delegate/home_page/qr_scanner/scan_failed.dart';
import 'package:sammilani_delegate/home_page/qr_scanner/scan_success_screen.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/model/offline_prasad.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QrScannerPrasad extends StatefulWidget {
  QrScannerPrasad({
    Key? key,
    this.role,
  }) : super(key: key);

  String? role;

  @override
  State<QrScannerPrasad> createState() => _QrScannerPrasadState();
}

class _QrScannerPrasadState extends State<QrScannerPrasad> {
  String? code;
  String offlinePrasadKey = "offline_prasad";
  final qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  int scannerCloseDuration = RemoteConfigHelper().getScannerCloseDuration;
  TextEditingController devoteeInfoController = TextEditingController();
  late String date, time;
  String prasadTiming = "";
  int totalCount = 0;
  int _offlineCounter = 0;
  List<OfflinePrasad> offlinePrasads = [];
  final _offlinePrasadFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    time = DateFormat("HH:mm").format(DateTime.now());
    // _initialize();
    fetchPrasadInfo();
    _loadCounter();
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

  _openQrScannerDialog(BuildContext context) async {
    try {
      if (context.mounted) {
        qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
          context: context,
          onCode: (code) async {
            try {
              final response =
                  await PutDevoteeAPI().updatePrasad(code.toString());
              print("API scan response: $response");
              _handleScanResponse(code.toString(), response);
            } on Exception catch (e) {
              print("error while scanning: $e");
            }
          },
        );
      }
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
            _openQrScannerDialog(context);
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
            print("***************  failure back");
            _openQrScannerDialog(context);
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
      print("json string list: $jsonStringList");
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

  void _saveCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _offlineCounter++;
      prefs.setInt('counter', _offlineCounter);
    });
  }

  Future<int> _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _offlineCounter = prefs.getInt('counter') ?? 0;
    });
    return _offlineCounter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppBarColor,
        title: const Text(
          'Prasad Scanner',
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        color: const Color.fromARGB(255, 250, 250, 233),
                        elevation: 10,
                        shadowColor: const Color.fromARGB(255, 250, 250, 233),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Current Status",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    date,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    prasadTiming,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              Text(
                                formatNumberWithCommas(totalCount),
                                style: const TextStyle(fontSize: 60),
                              ),
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: IconButton(
                                  onPressed: () async {
                                    await fetchPrasadInfo();
                                  },
                                  icon: const Icon(
                                    Icons.refresh_rounded,
                                    size: 60,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Card(
                        color: const Color.fromARGB(255, 250, 233, 233),
                        elevation: 10,
                        shadowColor: const Color.fromARGB(255, 250, 233, 233),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Offline Entry",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        offlinePrasads =
                                            await loadListFromPrefs(
                                                offlinePrasadKey);
                                        _offlineCounter = await _loadCounter();

                                        print(
                                            "******** offline prasads: $offlinePrasads");
                                        print(
                                            "******** counter: $_offlineCounter");

                                        if (offlinePrasads.isNotEmpty) {
                                          //todo 1 - api call
                                        }
                                        setState(() {
                                          devoteeInfoController.clear();
                                          _offlineCounter = 0;
                                        });
                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        prefs.remove(offlinePrasadKey);
                                        prefs.remove("counter");
                                      },
                                      icon: const Icon(
                                        Icons.upload,
                                        color: Colors.deepOrange,
                                      ))
                                ],
                              ),
                              Form(
                                key: _offlinePrasadFormKey,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextFormField(
                                    controller: devoteeInfoController,
                                    onSaved: (newValue) =>
                                        devoteeInfoController,
                                    // inputFormatters: [
                                    //   FilteringTextInputFormatter.allow(
                                    //       RegExp("[0-9 ,]"))
                                    // ],
                                    keyboardType: TextInputType.number,
                                    onChanged: (codeList) =>
                                        devoteeInfoController.text = codeList,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter devotee codes !';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: "Devotee Codes",
                                      labelStyle: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 15),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              width: 0,
                                              style: BorderStyle.solid)),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                height: 60,
                                width: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90)),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) {
                                        return Colors.deepOrange;
                                      }),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(90)))),
                                  onPressed: () async {
                                    if (_offlinePrasadFormKey.currentState
                                            ?.validate() ==
                                        true) {
                                      //todo save data in a list
                                      String date = DateFormat("yyyy-MM-dd")
                                              .format(DateTime.now()),
                                          time = DateFormat("HH:mm")
                                              .format(DateTime.now());
                                      OfflinePrasad prasads = OfflinePrasad(
                                        devoteeCodes: convertStringToList(
                                            devoteeInfoController.text),
                                        date: date,
                                        time: time,
                                      );
                                      await saveToPrefs(
                                        offlinePrasadKey,
                                        prasads,
                                      );
                                      devoteeInfoController.clear();
                                    }
                                  },
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text("OR"),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(90)),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.resolveWith(
                                                  (states) {
                                            return Colors.deepOrange;
                                          }),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          90)))),
                                      onPressed: () {
                                        _saveCounter();
                                      },
                                      child: const Text(
                                        'Add Offline Counter',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "$_offlineCounter",
                                    style: const TextStyle(fontSize: 40),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
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
                                      borderRadius:
                                          BorderRadius.circular(90)))),
                          onPressed: () {
                            _openQrScannerDialog(context);
                          },
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
              ),
            );
          }),
    );
  }
}
