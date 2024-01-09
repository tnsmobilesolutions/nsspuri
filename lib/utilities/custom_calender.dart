import 'package:flutter/material.dart';

class CustomCalender extends StatefulWidget {
  @override
  _CustomCalenderState createState() => _CustomCalenderState();
}

class _CustomCalenderState extends State<CustomCalender> {
  List<String> dates = List.generate(31, (index) => (index + 1).toString());
  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  List<String> years = List.generate(
      DateTime.now().year - 1879, (index) => (1880 + index).toString());

  String selectedDate = '1';
  String selectedMonth = 'Jan'; // Default to January
  String selectedYear = DateTime.now().year.toString();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              DropdownButton<String>(
                value: selectedDate,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDate = newValue!;
                  });
                },
                items: dates.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(width: 16),
              DropdownButton<String>(
                value: selectedMonth,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedMonth = newValue!;
                  });
                },
                items: months.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(width: 16),
              DropdownButton<String>(
                value: selectedYear,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedYear = newValue!;
                  });
                },
                items: years.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Selected Date: $selectedDate - $selectedMonth -$selectedYear',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // You can add any logic here before closing the dialog
              Navigator.of(context)
                  .pop('$selectedDate/$selectedMonth/$selectedYear');
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.deepOrange;
                  }
                  return Colors.deepOrange;
                }),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90)))),
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
