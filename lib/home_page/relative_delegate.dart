import 'package:flutter/material.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/screen/edit_devotee.dart';

// ignore: must_be_immutable
class RelativeDelegate extends StatelessWidget {
  RelativeDelegate({super.key, required this.devoteeData});
  Map<String, dynamic> devoteeData;

  @override
  Widget build(BuildContext context) {
    DevoteeModel devotee = devoteeData["data"];
    if (devotee.uid == null) {
      return const Center(child: Text("No data"));
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 0,
              // margin: const EdgeInsets.all(20),
              color: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    devotee.devoteeId != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 3.2,
                                ),
                                const Text(
                                  'ଜୟଗୁରୁ',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 6,
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return EditDevoteeDetailsPage(
                                              devotee: devotee);
                                        },
                                      ));
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.deepOrange,
                                    ))
                              ])
                        : const Center(
                            child: Text(
                              'ଜୟଗୁରୁ',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.black),
                            ),
                          ),
                    const Divider(
                      thickness: 1,
                      color: Color.fromARGB(240, 228, 228, 228),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                        child: CircleAvatar(
                          backgroundImage: devotee.profilePhotoUrl != null
                              ? Image.network(
                                  devotee.profilePhotoUrl.toString(),
                                  fit: BoxFit.cover,
                                ).image
                              : null,
                          radius: 40,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          devotee.name != null
                              ? Text(
                                  "Name       :   ${devotee.name}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300),
                                )
                              : const Text("Name : Please Update your Name"),
                          const SizedBox(
                            height: 10,
                          ),
                          devotee.sangha != null
                              ? Text(
                                  "Sangha    :    ${devotee.sangha}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300),
                                  softWrap: true, // Enable text wrapping
                                  overflow: TextOverflow
                                      .visible, // Define overflow behavior if the text doesn't fit
                                )
                              : const Text("Sanga : Please Update your Sangha"),
                          const SizedBox(
                            height: 10,
                          ),
                          devotee.mobileNumber != null
                              ? Text(
                                  "Mobile     :    ${devotee.mobileNumber}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300),
                                )
                              : const Text(
                                  "Mobile : Please Update your Mobile Number"),
                          const SizedBox(
                            height: 10,
                          ),
                          devotee.gender != null
                              ? Text(
                                  "Gender    :    ${devotee.gender}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300),
                                )
                              : const Text(
                                  "Gender : Please Update your Gender"),
                          const SizedBox(
                            height: 10,
                          ),
                          devotee.dob != null
                              ? Text(
                                  "DOB         :    ${devotee.dob}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300),
                                )
                              : const Text(
                                  "DOB : Please Update your Date of birth"),
                          const SizedBox(
                            height: 10,
                          ),
                          devotee.bloodGroup != null
                              ? Text(
                                  "Blood Gr :    ${devotee.bloodGroup}",
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
            ),
          ],
        ),
      ),
    );
  }
}