// ignore_for_file: avoid_print, must_be_immutable

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
import 'package:sammilani_delegate/utilities/color_palette.dart';

class QrScannerScreen extends StatefulWidget {
  QrScannerScreen({
    Key? key,
    this.role,
  }) : super(key: key);

  String? role;

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  String? code;
  final qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  late int scannerCloseDuration;
  TextEditingController devoteeInfoController = TextEditingController();
  late String date, time;
  String prasadTiming = "";
  int totalCount = 0;

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

  void _handleScanResponse(String code, Map<String, dynamic> response) async {
    try {
      if (response["statusCode"] == 200) {
        setState(() {
          this.code = code;
        });
        String status = response["data"]["status"];
        String devoteeName = "";
        String errorMessage = "";
        DevoteeModel devotee;

        if (response["data"]["devoteeData"] != null) {
          devotee = DevoteeModel.fromMap(response["data"]["devoteeData"]);
          devoteeName = devotee.name.toString();
        }

        if (status == "Success") {
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

  // void _showScanResultDialog(Map<String, dynamic> response, String title,
  //     Color dialogColor, Color buttonColor, Color textColor) {
  //   if (context.mounted) {
  //     print("scan response: $response");
  // Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) => ScanSuccess()),
  // );
  // showDialog(
  //     context: context,
  //     builder: (context) {
  //       Future.delayed(const Duration(milliseconds: 1000), () {
  //         Navigator.of(context).pop(true);
  //       });
  //       return PrasadScanResultDialog(
  //         response: response,
  //         role: widget.role,
  //         title: title,
  //         dialogColor: dialogColor,
  //         buttonColor: buttonColor,
  //         textColor: textColor,
  //       );
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppBarColor,
        title: const Text(
          'QR Scanner',
          style: TextStyle(color: Colors.white),
        ),
        leading: const SizedBox(),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                color: const Color.fromARGB(255, 250, 250, 233),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Current Status",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        "$totalCount",
                        style: const TextStyle(fontSize: 60),
                      ),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: IconButton(
                          onPressed: () async {
                            await fetchPrasadInfo();
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("api called")));
                            }
                            // Map<String, dynamic>? response =
                            //     await GetDevoteeAPI().prasdCountNow(date, time);
                            // if (response != null) {
                            //   setState(() {
                            //     totalCount = response["data"]["count"];
                            //   });
                            // }
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
              Card(
                color: const Color.fromARGB(255, 250, 233, 233),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Offline Entry",
                            style: TextStyle(fontSize: 15),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.upload,
                                color: Colors.deepOrange,
                              ))
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          controller: devoteeInfoController,
                          onSaved: (newValue) => devoteeInfoController,
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]"))
                          // ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter data';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "",
                            labelStyle: TextStyle(
                                color: Colors.grey[600], fontSize: 15),
                            // filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.solid)),
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
                                  MaterialStateProperty.resolveWith((states) {
                                return Colors.deepOrange;
                              }),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(90)))),
                          onPressed: () {},
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 60,
                            width: 200,
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
                              onPressed: () {},
                              child: const Text(
                                'Add Offline Counter',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const Text(
                            "10",
                            style: TextStyle(fontSize: 40),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(90)),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        return Colors.deepOrange;
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
      ),
    );
  }
}

// class PrasadScanResultDialog extends StatelessWidget {
//   PrasadScanResultDialog({
//     super.key,
//     required this.response,
//     required this.title,
//     this.role,
//     required this.dialogColor,
//     required this.textColor,
//     required this.buttonColor,
//   });

//   Color buttonColor;
//   Color dialogColor;
//   final Map<String, dynamic> response;
//   String? role;
//   Color textColor;
//   String title;

//   Widget getContent() {
//     try {
//       if (role == "PrasadScanner") {
//         if (response["statusCode"] == 200) {
//           return Text(
//             "${response["data"]["message"]}",
//             style: TextStyle(color: textColor, fontSize: 20),
//             textAlign: TextAlign.center,
//           );
//         } else {
//           return Text(
//             "${response["error"][0]}",
//             style: TextStyle(color: textColor, fontSize: 20),
//             textAlign: TextAlign.center,
//           );
//         }
//       } else {
//         if (response["statusCode"] == 200) {
//           return Text(
//             "${response["data"]}",
//             style: TextStyle(color: textColor, fontSize: 20),
//             textAlign: TextAlign.center,
//           );
//         } else {
//           return Text(
//             "Devotee not found !", //"${response["error"][0]}",
//             style: TextStyle(color: textColor, fontSize: 20),
//             textAlign: TextAlign.center,
//           );
//         }
//       }
//     } on Exception catch (e) {
//       print("scan error: $e");
//       return const ScaffoldMessenger(
//         child: SnackBar(
//           content: Text("Something went wrong !"),
//         ),
//       );
//     }
//   }

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

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: dialogColor,
//       title: Text(
//         title,
//         style: TextStyle(color: textColor, fontSize: 25),
//         textAlign: TextAlign.center,
//       ),
//       content: getContent(),
//       actions: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               height: 60,
//               width: 100,
//               decoration:
//                   BoxDecoration(borderRadius: BorderRadius.circular(90)),
//               child: ElevatedButton(
//                 style: ButtonStyle(
//                     backgroundColor:
//                         MaterialStateProperty.resolveWith((states) {
//                       return Colors.deepOrange;
//                     }),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(90)))),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text(
//                   'OK',
//                   style: TextStyle(
//                       color: dialogColor,
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
