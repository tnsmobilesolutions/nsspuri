import 'package:flutter/material.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';

class DelegateCard extends StatelessWidget {
  DelegateCard({super.key, required this.devotee});
  DevoteeModel devotee;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: Card(
          elevation: 8,
          margin: const EdgeInsets.all(20),
          color: Color.fromARGB(255, 204, 245, 249).withOpacity(.5),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'ଜୟଗୁରୁ',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Text("Name - ${devotee.name}"),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFFfa6e0f),
                      backgroundImage: devotee.profilePhotoUrl != null
                          ? Image.network(
                              devotee.profilePhotoUrl.toString(),
                              fit: BoxFit.cover,
                            ).image
                          : null,
                      radius: 60,
                    ),
                    Column(
                      children: [
                        Text("Sangha - ${devotee.sangha}"),
                        Text("Mobile - ${devotee.mobileNumber}"),
                        Text("Gender - ${devotee.gender}"),
                        Text("DOB - ${devotee.dob}"),
                        Text("BloodGroup - ${devotee.bloodGroup}"),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
