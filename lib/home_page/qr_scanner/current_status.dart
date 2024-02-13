// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentStatus extends StatefulWidget {
  final String date;
  final String prasadTiming;
  final int totalCount;
  final void Function()? onPressed;

  const CurrentStatus({
    super.key,
    required this.date,
    required this.prasadTiming,
    required this.totalCount,
    required this.onPressed,
  });

  @override
  _CurrentStatusState createState() => _CurrentStatusState();
}

class _CurrentStatusState extends State<CurrentStatus> {
  // Function to fetch prasad info
  Future<void> fetchPrasadInfo() async {
    // Your implementation here
  }

  String formatNumberWithCommas(int input) {
    final formatter = NumberFormat("#,###");
    String formattedNumber = formatter.format(input);

    return formattedNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.date,
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  widget.prasadTiming,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            Text(
              formatNumberWithCommas(widget.totalCount),
              style: const TextStyle(fontSize: 60),
            ),
            SizedBox(
              height: 80,
              width: 80,
              child: IconButton(
                onPressed: widget.onPressed,
                icon: Icon(
                  Icons.refresh_rounded,
                  size: 60,
                  color: widget.prasadTiming == "N/A"
                      ? Colors.grey
                      : Colors.deepOrange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
