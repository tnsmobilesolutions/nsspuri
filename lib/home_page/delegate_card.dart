import 'package:flutter/material.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/screen/edit_devotee.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';

// ignore: must_be_immutable
class DelegateCard extends StatelessWidget {
  DelegateCard({super.key, required this.devoteeData});
  Map<String, dynamic> devoteeData;

  @override
  Widget build(BuildContext context) {
    DevoteeModel devotee = devoteeData["data"];
    if (devotee.uid == null) {
      return const Center(child: Text("No data"));
    }
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              devotee.devoteeId != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.2,
                          ),
                          const Text(
                            'ଜୟଗୁରୁ',
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 6,
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return EditDevoteeDetailsPage(
                                        title: "edit", devotee: devotee);
                                  },
                                ));
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: IconButtonColor,
                              ))
                        ])
                  : const Center(
                      child: Text(
                        'ଜୟଗୁରୁ',
                      ),
                    ),
              const Divider(
                thickness: 1,
                color: DividerColor,
              ),
              const SizedBox(
                height: 4,
              ),
              Center(
                child: CircleAvatar(
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
                          )
                        : const Text("Name : Please Update your Name"),
                    const SizedBox(
                      height: 10,
                    ),
                    devotee.sangha != null
                        ? Text(
                            "Sangha    :    ${devotee.sangha}",

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
                          )
                        : const Text(
                            "Mobile : Please Update your Mobile Number"),
                    const SizedBox(
                      height: 10,
                    ),
                    devotee.gender != null
                        ? Text(
                            "Gender    :    ${devotee.gender}",
                          )
                        : const Text("Gender : Please Update your Gender"),
                    const SizedBox(
                      height: 10,
                    ),
                    devotee.dob != null
                        ? Text(
                            "DOB         :    ${devotee.dob}",
                          )
                        : const Text("DOB : Please Update your Date of birth"),
                    const SizedBox(
                      height: 10,
                    ),
                    devotee.bloodGroup != null
                        ? Text(
                            "Blood Gr :    ${devotee.bloodGroup}",
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
        ],
      ),
    );
  }
}
