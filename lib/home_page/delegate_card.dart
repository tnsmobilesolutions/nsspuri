import 'package:flutter/material.dart';

class DelegateCard extends StatelessWidget {
  const DelegateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: Card(
          elevation: 8,
          margin: const EdgeInsets.all(20),
          color: Color.fromARGB(255, 204, 245, 249).withOpacity(.5),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'ଜୟଗୁରୁ',
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
                // Text("Name - ${devotee.name}");
                // Text("Name - ${devotee.sangha}");
                // Text("Name - ${devotee.mobileNumber}");
                // Text("Name - ${devotee.gender}");
                // Text("Name - ${devotee.dateOf}");
                // Text("Name - ${devotee.name}");
                // Text("Name - ${devotee.name}");
              ],
            ),
          ),
        ),
      ),
    );
  }
}
