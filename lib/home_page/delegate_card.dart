import 'package:flutter/material.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';

// ignore: must_be_immutable
class DelegateCard extends StatelessWidget {
  DelegateCard({super.key, required this.devoteeData});
  Map<String, dynamic> devoteeData;

  @override
  Widget build(BuildContext context) {
    DevoteeModel? devotee = devoteeData["data"];
    if (devotee == null) {
      return const Center(child: Text("No data"));
    }
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 400,
        child: Card(
          elevation: 6,
          margin: const EdgeInsets.all(20),
          color: const Color.fromARGB(255, 225, 225, 225).withOpacity(.3),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
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
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          devotee.name != null
                              ? Text(
                                  "Name       :   ${devotee.name}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text("Name :- Please Update your Name"),
                          const SizedBox(
                            height: 10,
                          ),
                          devotee.sangha != null
                              ? Text(
                                  "Sangha    :     ${devotee.sangha}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  softWrap: true, // Enable text wrapping
                                  overflow: TextOverflow
                                      .visible, // Define overflow behavior if the text doesn't fit
                                )
                              : Text("Sanga :- Please Update your Sangha"),
                          const SizedBox(
                            height: 10,
                          ),
                          devotee.mobileNumber != null
                              ? Text(
                                  "Mobile     :    ${devotee.mobileNumber}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  "Mobile :- Please Update your Mobile Number"),
                          const SizedBox(
                            height: 10,
                          ),
                          devotee.gender != null
                              ? Text(
                                  "Gender    :    ${devotee.gender}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text("Gender :- Please Update your Gender"),
                          const SizedBox(
                            height: 10,
                          ),
                          devotee.dob != null
                              ? Text(
                                  "DOB         :    ${devotee.dob}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text("DOB :- Please Update your Date of birth"),
                          const SizedBox(
                            height: 10,
                          ),
                          devotee.bloodGroup != null
                              ? Text(
                                  "BloodGroup :    ${devotee.bloodGroup}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  "Bloodgroup :- Please Update your Bloodgroup"),
                        ],
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
      ),
    );
  }
}
