// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';

class ScanFailed extends StatefulWidget {
  ScanFailed({
    super.key,
    required this.devoteeName,
    required this.devoteeCode,
    this.status,
    required this.errorMessage,
    required this.closeDuration,
  });
  String? devoteeName, devoteeCode, errorMessage, status;
  int closeDuration;
  @override
  State<ScanFailed> createState() => _ScanFailedState();
}

class _ScanFailedState extends State<ScanFailed> {
  //String? code;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: widget.closeDuration), () {
      Navigator.pop(context, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ScaffoldBackgroundColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.deepOrange,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.devoteeName.toString(),
                    style: const TextStyle(fontSize: 40, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    widget.devoteeCode.toString(),
                    style: const TextStyle(fontSize: 30, color: Colors.yellow),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: null,
                child: Text(
                  widget.errorMessage.toString(),
                  style: const TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              const Icon(
                Icons.close,
                size: 150,
                color: Colors.white,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(90)),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        return Colors.white;
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(90)))),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 15,
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
