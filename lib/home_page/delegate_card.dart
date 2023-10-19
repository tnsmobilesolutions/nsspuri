import 'package:flutter/material.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';

class DelegateCard extends StatelessWidget {
  DelegateCard({super.key, required this.devotee});
  DevoteeModel devotee;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 400,
        child: Card(
          elevation: 6,
          margin: const EdgeInsets.all(20),
          color: Color.fromARGB(255, 225, 225, 225).withOpacity(.3),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Center(
                  child: Text(
                    'ଜୟଗୁରୁ',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                const SizedBox(
                  height: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFFfa6e0f),
                      backgroundImage: devotee.profilePhotoUrl != null
                          ? Image.network(
                              devotee.profilePhotoUrl.toString(),
                              fit: BoxFit.cover,
                            ).image
                          : null,
                      radius: 40,
                    ),
                    Text(
                      "Name       :   ${devotee.name}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Sangha    :     ${devotee.sangha}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      softWrap: true, // Enable text wrapping
                      overflow: TextOverflow
                          .visible, // Define overflow behavior if the text doesn't fit
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Mobile     :    ${devotee.mobileNumber}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Gender    :    ${devotee.gender}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "DOB         :    ${devotee.dob}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "BloodGroup :    ${devotee.bloodGroup}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
