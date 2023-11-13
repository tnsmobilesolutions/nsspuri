import 'package:flutter/material.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/screen/edit_devotee.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';

// ignore: must_be_immutable
class RelativeDelegate extends StatelessWidget {
  RelativeDelegate({super.key, required this.devoteeData});
  Map<String, dynamic> devoteeData;
  String _toCamelCase(String input) {
    if (input.isEmpty) {
      return input;
    }

    final words = input.split(' ');
    final camelCaseWords = words.map((word) {
      if (word.isEmpty) {
        return '';
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    });

    return camelCaseWords.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final devotees = devoteeData["data"];
    if (devotees.isEmpty) {
      return const Center(child: Text("No data"));
    }
    // print(
    //     "************* ${devoteeData['bloodGroup'] ?? 'No blood group available'}");

    // devoteedata['bloodGroup'] != null &&
    //         devoteedata['bloodGroup'] != "Don't know"
    //     ? const Stack()
    //     : Container();

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
                borderRadius: BorderRadius.circular(30),
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
                child: PageView.builder(
                  itemCount: devotees.length,
                  // shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    DevoteeModel devoteedata =
                        DevoteeModel.fromMap(devotees[index]);
                    BoxDecoration(
                      color: ContainerColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ContainerBoxShadowColor,
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    );
                    // DevoteeModel singledevotee =
                    //     DevoteeModel.fromMap(devotees[index]);
                    return Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            border: Border.all(
                                width: .5,
                                color:
                                    const Color.fromARGB(255, 230, 230, 230))),
                        height: MediaQuery.of(context).size.height / 1.6,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                height: 90,

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
                                                color:
                                                    Colors.white, // Text color
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              'Nilachala Saraswat Sangha, Puri',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color:
                                                    Colors.white, // Text color
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
                                                color:
                                                    Colors.white, // Text color
                                              ),
                                            ),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              'PUNE-2024',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color:
                                                      Colors.white // Text color
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 32),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    const Text(
                                      'IDENTITY CARD',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
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
                              ),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: devoteedata.bloodGroup ==
                                              "Don't know"
                                          ? Container(
                                              width: 75,
                                              height: 60,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.rectangle,
                                              ),
                                            )
                                          : Stack(
                                              children: [
                                                Container(
                                                  width: 75,
                                                  height: 60,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: AssetImage(
                                                          'assets/images/blood.png'),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 28,
                                                  left: 25,
                                                  child: Center(
                                                    child: Text(
                                                      "${devoteedata.bloodGroup}",
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                      // Return an empty Container if the condition is false
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Container(
                                      height: 150,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 212, 212, 212),
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
                                    const SizedBox(
                                      width: 78,
                                    )
                                  ],
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
                                          "${_toCamelCase(devoteedata.name.toString())}",
                                          style: const TextStyle(
                                              color: Colors.deepOrange,
                                              fontSize: 28,
                                              fontWeight: FontWeight.w600),
                                        )
                                      : const Text(
                                          "Name : Please Update your Name"),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  devoteedata.sangha != null
                                      ? Text(
                                          "${_toCamelCase(devoteedata.sangha.toString())}",
                                          style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : const Text(
                                          "Name : Please Update your Sangha"),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    devoteedata.mobileNumber != null
                                        ? Text(
                                            "Mobile     :    ${devoteedata.mobileNumber}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : const Text(
                                            "Mobile : Please Update your Mobile Number"),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    devoteedata.gender != null
                                        ? Text(
                                            "Gender    :    ${_toCamelCase(devoteedata.gender.toString())}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
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
                                                fontWeight: FontWeight.bold),
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
                              const SizedBox(
                                height: 22,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: ContainerCardColor,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30.0),
                                    bottomRight: Radius.circular(30.0),
                                  ),
                                ),
                                width: 400,
                                height: 35,
                                child: const Padding(
                                  padding: EdgeInsets.only(top: 0, left: 0),
                                ),

                                // Background color of the container
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
