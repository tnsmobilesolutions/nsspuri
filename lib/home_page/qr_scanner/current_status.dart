// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentStatus extends StatefulWidget {
  final String date;
  final String prasadTiming;
  final int totalCount;
  final int offlineCount;
  final int onlineCount;
  final bool isOnline;
  final void Function()? onPressed;

  const CurrentStatus({
    super.key,
    required this.date,
    required this.prasadTiming,
    required this.isOnline,
    required this.offlineCount,
    required this.onlineCount,
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
      color: const Color.fromARGB(255, 207, 232, 253),
      elevation: 10,
      shadowColor: const Color.fromARGB(255, 250, 250, 233),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Current Status",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: widget.onPressed,
                  icon: Icon(
                    Icons.refresh_rounded,
                    size: 60,
                    color:
                        // widget.prasadTiming == "N/A" ||
                        !widget.isOnline ? Colors.grey : Colors.deepOrange,
                  ),
                ),
              ],
            ),
            // Text(
            //   "${widget.onlineCount} + ${widget.offlineCount} = ${widget.totalCount}",
            //   style: const TextStyle(fontSize: 60),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formatNumberWithCommas(widget.onlineCount),
                  style: const TextStyle(
                      fontSize: 30, color: Color.fromARGB(255, 6, 127, 10)),
                ),
                const SizedBox(width: 10),
                const Text(
                  "+",
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(width: 10),
                Text(
                  formatNumberWithCommas(widget.offlineCount),
                  style:
                      const TextStyle(fontSize: 30, color: Colors.deepOrange),
                ),
                const SizedBox(width: 10),
                const Text(
                  "=",
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(width: 10),
                Text(
                  formatNumberWithCommas(widget.totalCount),
                  style: const TextStyle(fontSize: 60),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.date,
                  style: const TextStyle(fontSize: 25),
                ),
                Text(
                  widget.prasadTiming,
                  style: const TextStyle(fontSize: 25),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
