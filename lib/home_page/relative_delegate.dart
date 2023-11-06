import 'package:flutter/material.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/screen/edit_devotee.dart';

// ignore: must_be_immutable
class RelativeDelegate extends StatelessWidget {
  RelativeDelegate({super.key, required this.devoteeData});
  Map<String, dynamic> devoteeData;

  @override
  Widget build(BuildContext context) {
    final devotees = devoteeData["data"];
    if (devotees.isEmpty) {
      return const Center(child: Text("No data"));
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // const Text(
            //   'ଜୟଗୁରୁ',
            //   style: TextStyle(
            //       fontSize: 24,
            //       fontWeight: FontWeight.w300,
            //       color: Colors.black),
            // ),
            // const Divider(
            //   thickness: 1,
            //   color: Color.fromARGB(240, 228, 228, 228),
            // ),
            ListView.builder(
              itemCount: devotees.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                DevoteeModel devoteedata =
                    DevoteeModel.fromMap(devotees[index]);
                // DevoteeModel singledevotee =
                //     DevoteeModel.fromMap(devotees[index]);
                return Card(
                  elevation: 0,
                  // margin: const EdgeInsets.all(20),
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Center(
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 35,
                                child: CircleAvatar(
                                  backgroundImage:
                                      devoteedata.profilePhotoUrl != null
                                          ? Image.network(
                                              devoteedata.profilePhotoUrl
                                                  .toString(),
                                              fit: BoxFit.cover,
                                            ).image
                                          : null,
                                  radius: 40,
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return EditDevoteeDetailsPage(
                                          title: "edit", devotee: devoteedata);
                                    },
                                  ));
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.deepOrange,
                                ))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              devoteedata.name != null
                                  ? Text(
                                      "Name       :   ${devoteedata.name}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    )
                                  : const Text(
                                      "Name : Please Update your Name"),
                              const SizedBox(
                                height: 10,
                              ),
                              devoteedata.sangha != null
                                  ? Text(
                                      "Sangha    :    ${devoteedata.sangha}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                      softWrap: true, // Enable text wrapping
                                      overflow: TextOverflow
                                          .visible, // Define overflow behavior if the text doesn't fit
                                    )
                                  : const Text(
                                      "Sanga : Please Update your Sangha"),
                              const SizedBox(
                                height: 10,
                              ),
                              devoteedata.mobileNumber != null
                                  ? Text(
                                      "Mobile     :    ${devoteedata.mobileNumber}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    )
                                  : const Text(
                                      "Mobile : Please Update your Mobile Number"),
                              const SizedBox(
                                height: 10,
                              ),
                              devoteedata.gender != null
                                  ? Text(
                                      "Gender    :    ${devoteedata.gender}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    )
                                  : const Text(
                                      "Gender : Please Update your Gender"),
                              const SizedBox(
                                height: 10,
                              ),
                              devoteedata.dob != null
                                  ? Text(
                                      "DOB         :    ${devoteedata.dob}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    )
                                  : const Text(
                                      "DOB : Please Update your Date of birth"),
                              const SizedBox(
                                height: 10,
                              ),
                              devoteedata.bloodGroup != null
                                  ? Text(
                                      "Blood Gr :    ${devoteedata.bloodGroup}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    )
                                  : const Text(
                                      "Bloodgroup : Please Update your Bloodgroup"),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
