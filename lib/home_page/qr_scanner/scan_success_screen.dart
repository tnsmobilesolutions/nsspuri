// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';

class ScanSuccess extends StatefulWidget {
  ScanSuccess({
    super.key,
    this.devoteeName,
    this.devoteeCode,
    required this.closeDuration,
  });
  String? devoteeName, devoteeCode;
  int closeDuration;
  @override
  State<ScanSuccess> createState() => _ScanSuccessState();
}

class _ScanSuccessState extends State<ScanSuccess> {
  //String? code;
  String? devoteename;
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
        color: Colors.green,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${widget.devoteeName}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 40, color: Colors.white),
              ),
              Text(
                "${widget.devoteeCode}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 30, color: Colors.white),
              ),
              const Icon(
                Icons.done,
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
                        color: Colors.green,
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
