import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:sammilani_delegate/enums/devotee_status.dart';
import 'package:sammilani_delegate/home_page/card_flip.dart';
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
  final con = FlipCardController();
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
      return const Color.fromARGB(255, 220, 31, 18);
    } else if (devotee.dob != "" && devotee.dob != null) {
      if (isValidDateFormat(devotee.dob.toString())) {
        if (devotee.isSpeciallyAbled == true ||
            calculateAge(DateTime.parse(devotee.dob.toString())) >= 70) {
          return Colors.purple;
        } else if (calculateAge(DateTime.parse(devotee.dob.toString())) <= 12) {
          return Colors.green;
        } else {
          return Colors.blue;
        }
      } else {
        return Colors.blue;
      }
    } else if (devotee.gender == "Male") {
      return Colors.blue;
    } else if (devotee.gender == "Female") {
      return const Color.fromARGB(255, 254, 117, 163);
    } else {
      return Colors.blue;
    }
  }

  bool isValidDateFormat(String date) {
    // Check if the date is in the format yyyy-mm-dd
    final RegExp dateFormat = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    return dateFormat.hasMatch(date);
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

  String _toPascalCase(String input) {
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
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.4,
      child: PageIndicatorContainer(
        length: devotees.length,
        align: IndicatorAlign.bottom,
        indicatorSpace: 10.0,
        // padding: const EdgeInsets.all(30),
        indicatorColor: Colors.blueAccent,
        indicatorSelectorColor: Colors.white,
        shape: IndicatorShape.circle(size: 8),
        child: PageView.builder(
            itemCount: devotees.length,
            controller: PageController(),
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              DevoteeModel devoteedata = DevoteeModel.fromMap(devotees[index]);
              return FlipCard(
                rotateSide: RotateSide.right,
                onTapFlipping: false,
                axis: FlipAxis.vertical,
                controller: con,
                backWidget: CardFlip(color: getColorByDevotee(devoteedata)),
                frontWidget: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 12, right: 12),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.4,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          // getColorByDevotee(devoteedata),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 194, 202, 218),
                            ),
                          ],
                          border: Border.all(
                            width: 3,
                            color: const Color.fromARGB(255, 233, 233, 233),
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(.0),
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 13,
                              decoration: BoxDecoration(
                                  color: getColorByDevotee(devoteedata),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(18),
                                    topRight: Radius.circular(18),
                                  )),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      child: const Text(''),
                                    ),
                                  ),

                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      child: const Text(
                                        'DELEGATE CARD',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // const SizedBox(
                                  //   width: 50,
                                  // ),
                                  Expanded(
                                    flex: 2,
                                    child: devoteedata.status == "dataSubmitted"
                                        ? Container(
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
                                                  size: 20,
                                                  color: Colors.white),
                                            ),
                                          )
                                        : Container(), // You can use an empty Container or any other widget based on your requirements
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 1.79,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: ListView.separated(
                                      itemCount: 20,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return SvgPicture.asset(
                                          'assets/images/3.svg',
                                          color: getColorByDevotee(devoteedata),
                                          height: 20,
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        // This widget will be used as a separator between items.
                                        // You can adjust the size and appearance of the separator here.
                                        return SizedBox(
                                            height:
                                                3); // Adjust the height as needed.
                                      },
                                    ),
                                  ),
                                  Expanded(
                                      flex: 8,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  child: Image.asset(
                                                    'assets/images/nsslogo.png',
                                                    scale: 35,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Container(
                                                  child: const Center(
                                                    child: Text(
                                                      'JAYAGURU',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .black // Text color
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  child: Image.asset(
                                                    'assets/images/Subtract.png',
                                                    scale: 85,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Text(
                                            'NILACHALA SARASWATA SANGHA, PURI',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors
                                                    .deepOrange // Text color
                                                ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            '73RD UTKALA PRADESHIKA',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color:
                                                    Colors.black // Text color
                                                ),
                                          ),
                                          const Text(
                                            'BHAKTA SAMMILANI, PUNE - 2024',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color:
                                                    Colors.black // Text color
                                                ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    child: devoteedata
                                                                    .bloodGroup ==
                                                                "Don't know" ||
                                                            devoteedata
                                                                    .bloodGroup ==
                                                                null
                                                        ? Container(
                                                            width: 75,
                                                            height: 60,
                                                            decoration:
                                                                const BoxDecoration(
                                                              shape: BoxShape
                                                                  .rectangle,
                                                            ),
                                                          )
                                                        : Center(
                                                            child: Stack(
                                                              children: [
                                                                Container(
                                                                  width: 75,
                                                                  height: 60,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .rectangle,
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      image: AssetImage(
                                                                          'assets/images/blood.png'),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  top: 7,
                                                                  left: 0,
                                                                  child:
                                                                      SizedBox(
                                                                    width: 75,
                                                                    height: 60,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "${devoteedata.bloodGroup}",
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              255),
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                    // Return an empty Container if the condition is false
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 9,
                                                  child: Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      Positioned(
                                                        child: Container(
                                                          width: 145,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: getColorByDevotee(
                                                                  devoteedata),
                                                              width: 3,
                                                            ),
                                                            shape:
                                                                BoxShape.circle,
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  devoteedata
                                                                      .profilePhotoUrl
                                                                      .toString()),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      if (devoteedata.status !=
                                                          DevoteeStatus
                                                              .dataSubmitted
                                                              .name)
                                                        Positioned(
                                                          top: 50,
                                                          left: 105,
                                                          child:
                                                              Transform.rotate(
                                                            angle: 12,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color: const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            44,
                                                                            7,
                                                                            209),
                                                                        width:
                                                                            4),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4)),
                                                                child:
                                                                    const Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              4.0),
                                                                  child: Text(
                                                                    'PAID',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          40.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          44,
                                                                          7,
                                                                          209),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          devoteedata.name != null
                                              ? Text(
                                                  _toPascalCase(devoteedata.name
                                                      .toString()),
                                                  style: const TextStyle(
                                                    color: Colors.deepOrange,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              : const Text(""),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Flexible(
                                                  flex: 1,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      devoteedata.sangha != null
                                                          ? Text(
                                                              _toPascalCase(
                                                                  devoteedata
                                                                      .sangha
                                                                      .toString()),
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            )
                                                          : const Text(""),
                                                      devoteedata.devoteeCode !=
                                                              null
                                                          ? Text(
                                                              _toPascalCase(
                                                                  devoteedata
                                                                      .devoteeCode
                                                                      .toString()),
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .deepOrange,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            )
                                                          : const Text(""),
                                                      const Text(
                                                        "Sri Sri Thakura Charanasrita",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const Text(
                                                        "",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const Text(
                                                        "",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const Text(
                                                        'Secretary',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Flexible(
                                                  flex: 2,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            4.8,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            4.8,
                                                    child: SfBarcodeGenerator(
                                                      value: devoteedata
                                                          .devoteeCode
                                                          .toString(),
                                                      symbology: QRCode(),
                                                      showValue: false,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                    child: ListView.separated(
                                      itemCount: 20,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return SvgPicture.asset(
                                          'assets/images/3.svg',
                                          color: getColorByDevotee(devoteedata),
                                          height: 20,
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        // This widget will be used as a separator between items.
                                        // You can adjust the size and appearance of the separator here.
                                        return SizedBox(
                                            height:
                                                3); // Adjust the height as needed.
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 17, left: 5, right: 5),
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 13, // Number of columns
                                    crossAxisSpacing:
                                        4.0, // Adjust the spacing between columns
                                    mainAxisSpacing:
                                        8.0, // Adjust the spacing between rows
                                  ),
                                  itemCount:
                                      12, // Change this number based on your actual requirement
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return SvgPicture.asset(
                                      'assets/images/3.svg',
                                      height: 20,
                                      color: getColorByDevotee(devoteedata),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
