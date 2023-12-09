

import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/screen/edit_devotee.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

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

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  Color getColorByDevotee(DevoteeModel devotee) {
    if (devotee.isGuest == true) {
      return Colors.yellow;
    } else if (devotee.isOrganizer == true) {
      return Colors.red;
    } else if (devotee.isSpeciallyAbled == true ||
        calculateAge(DateTime.parse(devotee.dob ?? "2000-01-01")) >= 60) {
      return Colors.purple;
    } else if (calculateAge(DateTime.parse(devotee.dob ?? "2000-01-01")) <=
        18) {
      return Colors.green;
    } else if (devotee.gender == "Male") {
      return Colors.blue;
    } else if (devotee.gender == "Female") {
      return Colors.pink;
    } else {
      return Colors.blue;
    }
  }

  int calculateAge(DateTime dob) {
    DateTime now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age;
  }

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
    final devotees = widget.devoteeData["data"];
    if (devotees.isEmpty) {
      return const Center(child: Text("No data"));
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
        child: Container(
          height: 550,
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 194, 202, 218),
                  spreadRadius: 8,
                  blurRadius: 8,
                ),
              ],
              border: Border.all(
                  width: 10, color: const Color.fromARGB(255, 233, 233, 233)),
              borderRadius: const BorderRadius.all(Radius.circular(35))),
          child: PageIndicatorContainer(
            length: devotees.length,
            align: IndicatorAlign.bottom,
            indicatorSpace: 10.0,
            padding: const EdgeInsets.all(10),
            indicatorColor: Colors.red,
            indicatorSelectorColor: Colors.red,
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

                // DevoteeModel singledevotee =
                //     DevoteeModel.fromMap(devotees[index]);
                return Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Stack(
                          children: [
                            Positioned(
                              child: Image.asset(
                                'assets/images/nsslogo.png',
                                scale: 35,
                              ),
                            ),
                            const Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'JAYAGURU',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white, // Text color
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Text(
                                    'Nilachala Saraswata Sangha, Puri',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white, // Text color
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    '73RD UTKAL PRADESHIKA BHAKTA SAMMILANI',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.white, // Text color
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    'PUNE-2024',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
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
                      height: 410,
                      width: 400,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text(''),
                              ),
                              const Expanded(
                                flex: 4,
                                child: Center(
                                  child: Text(
                                    'DELEGATE CARD',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              // const SizedBox(
                              //   width: 50,
                              // ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
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
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Center(
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 28,
                                ),
                                Container(
                                  child: devoteedata.bloodGroup ==
                                              "Don't know" ||
                                          devoteedata.bloodGroup == null
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
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      child: Container(
                                        height: 170,
                                        width: 130,
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
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          devoteedata.name != null
                              ? Text(
                                  _toCamelCase(devoteedata.name.toString())
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : const Text("Name : Name"),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                devoteedata.sangha != null
                                    ? Expanded(
                                        child: Text(
                                          "${devoteedata.sangha}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    : const Text(""),
                                Expanded(
                                  child: Container(
                                    height: 140,
                                    width: 100,
                                    child: SfBarcodeGenerator(
                                      value: devoteedata.devoteeCode.toString(),
                                      symbology: QRCode(),
                                      showValue: false,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'SAMPADAK:',
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
