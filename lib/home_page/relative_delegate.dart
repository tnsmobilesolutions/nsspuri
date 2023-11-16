import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/screen/edit_devotee.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';

// ignore: must_be_immutable
class RelativeDelegate extends StatefulWidget {
  RelativeDelegate({super.key, required this.devoteeData});
  Map<String, dynamic> devoteeData;

  @override
  State<RelativeDelegate> createState() => _RelativeDelegateState();
}

class _RelativeDelegateState extends State<RelativeDelegate> {
  late PageController controller;
  GlobalKey<PageContainerState> key = GlobalKey();

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
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    final devotees = widget.devoteeData["data"];
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
        padding: const EdgeInsets.only(top: 40, left: 12, right: 12),
        child: SizedBox(
          height: 550,
          child: Container(
            color: Color.fromARGB(255, 242, 247, 254),
            child: PageIndicatorContainer(
                length: devotees.length,
                align: IndicatorAlign.bottom,
                indicatorSpace: 10.0,
                padding: const EdgeInsets.all(10),
                indicatorColor: Colors.grey,
                indicatorSelectorColor:
                    const Color.fromARGB(255, 255, 255, 255),
                shape: IndicatorShape.circle(size: 8),
                child: PageView.builder(
                  itemCount: devotees.length,
                  controller: PageController(),

                  // shrinkWrap: true,
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) {
                    DevoteeModel devoteedata =
                        DevoteeModel.fromMap(devotees[index]);
                    BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ContainerBoxShadowColor,
                          spreadRadius: 4,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    );
                    // DevoteeModel singledevotee =
                    //     DevoteeModel.fromMap(devotees[index]);
                    return Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: AppBarColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          width: 400,
                          height: 100,

                          // Background color of the container
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 2,
                                ),
                                Image.asset(
                                  'assets/images/nsslogo.png',
                                  scale: 25,
                                ),
                                SizedBox(
                                  width: 12,
                                ),

                                // Replace with your image path

                                const Padding(
                                  padding: EdgeInsets.only(top: 7),
                                  child: Column(
                                    children: [
                                      Text(
                                        'JAYAGURU',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white, // Text color
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        'Nilachala Saraswat Sangha, Puri',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white, // Text color
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
                                          color: Colors.white, // Text color
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
                                            color: Colors.white // Text color
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 415,
                          width: 400,
                          color: Color.fromARGB(255, 255, 255, 255),
                          child: Column(
                            children: [
                              Center(
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 124,
                                    ),
                                    const Text(
                                      'IDENTITY CARD',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 60,
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
                                      icon: const Icon(Icons.edit,
                                          size: 20, color: IconButtonColor),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
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
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: AssetImage(
                                                        'assets/images/blood.png'),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 7,
                                                left: 0,
                                                child: SizedBox(
                                                  width: 75,
                                                  height: 60,
                                                  child: Center(
                                                    child: Text(
                                                      "${devoteedata.bloodGroup}",
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
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
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: devoteedata.name != null
                                    ? Text(
                                        _toCamelCase(
                                            devoteedata.name.toString()),
                                        style: const TextStyle(
                                            color: Colors.deepOrange,
                                            fontSize: 28,
                                            fontWeight: FontWeight.w600),
                                      )
                                    : const Text(
                                        "Name : Please Update your Name"),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Center(
                                child: devoteedata.sangha != null
                                    ? Text(
                                        _toCamelCase(
                                            devoteedata.sangha.toString()),
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : const Text(
                                        "Name : Please Update your Sangha"),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Center(
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
                            ],
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: AppBarColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0),
                            ),
                          ),
                          width: 400,
                          height: 35,
                          child: const Padding(
                            padding: EdgeInsets.only(top: 8, left: 15),
                            child: Text(
                              "PARICHALAK :",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),

                          // Background color of the container
                        ),
                      ],
                    );
                  },
                )),
          ),
        ),
      ),
    );
  }
}
