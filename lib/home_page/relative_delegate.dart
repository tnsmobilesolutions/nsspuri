import 'package:flutter/material.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/screen/edit_devotee.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';

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
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: ContainerColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: ContainerBoxShadowColor,
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  elevation: Theme.of(context).cardTheme.elevation,
                  shape: Theme.of(context).cardTheme.shape,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListView.builder(
                        itemCount: devotees.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          DevoteeModel devoteedata =
                              DevoteeModel.fromMap(devotees[index]);
                          // DevoteeModel singledevotee =
                          //     DevoteeModel.fromMap(devotees[index]);
                          return SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: ContainerCardColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.0),
                                        topRight: Radius.circular(30.0),
                                      ),
                                    ),
                                    width: 400,
                                    height: 80,

                                    // Background color of the container
                                    child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Image.asset(
                                            'assets/images/nsslogo.png',
                                            scale: 25,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                            width: 5,
                                          ),
                                          // Replace with your image path

                                          const Padding(
                                            padding: EdgeInsets.all(1),
                                            child: Column(
                                              children: [
                                                Text(
                                                  'JAYAGURU',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors
                                                        .white, // Text color
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  'Nilachala Saraswat Sangha, Puri',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors
                                                        .white, // Text color
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Text(
                                                  '73RD UTKAL PRADESHIKA SAMMILANI',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors
                                                        .white, // Text color
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Text(
                                                  'Pune-2023',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors
                                                        .white, // Text color
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return EditDevoteeDetailsPage(
                                                  title: "edit",
                                                  devotee: devoteedata,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        alignment: Alignment.centerRight,
                                        icon: const Icon(Icons.edit,
                                            size: 20, color: IconButtonColor),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 0,
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Text(
                                          'IDENTITY CARD',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Center(
                                    child: Container(
                                      height: 150,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 92, 32, 183),
                                          width: 1,
                                        ),
                                        shape: BoxShape
                                            .rectangle, // This makes the container circular
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(devoteedata
                                              .profilePhotoUrl
                                              .toString()),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      devoteedata.name != null
                                          ? Text(
                                              "${devoteedata.name}",
                                              style: const TextStyle(
                                                  color: Colors.deepOrange,
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          : const Text(
                                              "Name : Please Update your Name"),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      devoteedata.sangha != null
                                          ? Text(
                                              "${devoteedata.sangha}",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : const Text(
                                              "Name : Please Update your Sangha"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        devoteedata.mobileNumber != null
                                            ? Text(
                                                "Mobile     :    ${devoteedata.mobileNumber}",
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : const Text(
                                                "Mobile : Please Update your Mobile Number"),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        devoteedata.gender != null
                                            ? Text(
                                                "Gender    :    ${devoteedata.gender}",
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : const Text(
                                                "Gender : Please Update your Gender"),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        devoteedata.dob != null
                                            ? Text(
                                                "DOB         :    ${devoteedata.dob}",
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : const Text(
                                                "DOB : Please Update your Date of birth"),

                                        // devoteedata.bloodGroup != null
                                        //     ? Text(
                                        //         "Blood Gr :    ${devoteedata.bloodGroup}",
                                        //         style: const TextStyle(
                                        //             fontSize: 18,
                                        //             fontWeight:
                                        //                 FontWeight.w300),
                                        //       )
                                        //     : const Text(
                                        //         "Bloodgroup : Please Update your Bloodgroup"),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(30.0),
                                        bottomRight: Radius.circular(30.0),
                                      ),
                                    ),
                                    width: 400,
                                    height: 34,
                                    child: const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        'Parichalak:',
                                        style: TextStyle(
                                            color: ButtonTextStyleColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),

                                    // Background color of the container
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
