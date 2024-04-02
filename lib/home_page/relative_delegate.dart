// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:sammilani_delegate/API/events.dart';
import 'package:sammilani_delegate/API/get_devotee.dart';
import 'package:sammilani_delegate/home_page/card_flip.dart';
import 'package:sammilani_delegate/home_page/constants.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/model/event_model.dart';
import 'package:sammilani_delegate/screen/edit_devotee.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:uuid/uuid.dart';


class RelativeDelegate extends StatefulWidget {
  RelativeDelegate({
    super.key,
    required this.devoteeData,
    this.editedDevoteeIndex,
  });

  Map<String, dynamic> devoteeData;
  int? editedDevoteeIndex;

  @override
  State<RelativeDelegate> createState() => _RelativeDelegateState();
}

class _RelativeDelegateState extends State<RelativeDelegate> {
  final con = FlipCardController();
  late PageController controller;
  DevoteeModel? currentDevotee;
  GlobalKey<PageContainerState> key = GlobalKey();
  int updatedPageIndex = 0;

  @override
  void initState() {
    super.initState();

    controller = PageController(
        initialPage: widget.editedDevoteeIndex ?? updatedPageIndex);
    getDevotee(); // Set initialPage
  }

  getDevotee() async {
    final devoteeData = await GetDevoteeAPI().currentDevotee();
    print("devotee data: $devoteeData");
    if (mounted && devoteeData != null && devoteeData.containsKey("data")) {
      setState(() {
        currentDevotee = devoteeData["data"];
      });
    }
  }

  // bool isValidDateFormat(String date) {
  //   // Check if the date is in the format yyyy-mm-dd
  //   final RegExp dateFormat = RegExp(r'^\d{4}-\d{2}-\d{2}$');
  //   return dateFormat.hasMatch(date);
  // }

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
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.1,
          child: PageView.builder(
              itemCount: devotees.length,
              controller: controller,
              onPageChanged: (index) {
                // Update updatedPageIndex when the page changes
                updatedPageIndex = index;
              },
              itemBuilder: (
                BuildContext context,
                int index,
              ) {
                DevoteeModel devoteedata =
                    DevoteeModel.fromMap(devotees[index]);
                // if (devoteedata.eventAttendance != null)
                // {
                return Column(
                  children: [
                    Text(
                        'Are you coming to Centenary Celebration at Puri on 14th April?',
                        textAlign: TextAlign.center),
                    SizedBox(
                      height: 12,
                    ),
                    ToggleSwitch(
                      minWidth: 45.0,
                      initialLabelIndex:
                          devoteedata.eventAttendance == true ? 0 : 1,
                      cornerRadius: 12.0,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.white,
                      inactiveFgColor: Colors.grey,
                      borderColor: [Colors.grey],
                      borderWidth: 1,
                      totalSwitches: 2,
                      labels: ['Yes', 'No'],
                      activeBgColors: [
                        [Colors.blue],
                        [Colors.blue]
                      ],
                      onToggle: (toggleIndex) async {
                        if (toggleIndex == 0) {
                          EventModel eventData = EventModel(
                            devoteeCode: devoteedata.devoteeCode,
                            devoteeId: devoteedata.devoteeId,
                            eventAntendeeId: Uuid().v4(),
                            inDate: '2023-04-14',
                            outDate: '2023-04-14',
                            eventId: '1',
                            eventName: 'Puri',
                            eventAttendance: true,
                          );
                          await EventsAPI().addEvent(eventData);
                          print("yes");
                          // Navigator.of(context).pop();
                        } else {
                          EventModel eventData = EventModel(
                            devoteeCode: devoteedata.devoteeCode,
                            devoteeId: devoteedata.devoteeId,
                            eventAntendeeId: Uuid().v4(),
                            inDate: '2023-04-14',
                            outDate: '2023-04-14',
                            eventId: '1',
                            eventName: 'Puri',
                            eventAttendance: false,
                          );
                          await EventsAPI().addEvent(eventData);
                          print("NO");

                          // Navigator.of(context).pop();
                        }
                      },
                    ),
                    FlipCard(
                      rotateSide: RotateSide.right,
                      onTapFlipping: false,
                      axis: FlipAxis.vertical,
                      controller: con,
                      backWidget:
                          CardFlip(color: getColorByDevotee(devoteedata)),
                      frontWidget: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 12, right: 12),
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
                                  color:
                                      const Color.fromARGB(255, 233, 233, 233),
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: Padding(
                                padding: const EdgeInsets.all(.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              13,
                                      decoration: BoxDecoration(
                                          color: getColorByDevotee(devoteedata),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(18),
                                            topRight: Radius.circular(18),
                                          )),
                                      child: Row(
                                        children: [
                                          const Expanded(
                                            flex: 2,
                                            child: Text(''),
                                          ),

                                          const Expanded(
                                            flex: 4,
                                            child: Text(
                                              'DELEGATE',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          // const SizedBox(
                                          //   width: 50,
                                          // ),
                                          Expanded(
                                            flex: 2,
                                            child: devoteedata.status ==
                                                        "dataSubmitted" ||
                                                    devoteedata.status ==
                                                        "rejected"
                                                ? IconButton(
                                                    onPressed: () async {
                                                      await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) {
                                                            return EditDevoteeDetailsPage(
                                                              title: "edit",
                                                              isRelatives: currentDevotee
                                                                          ?.devoteeId ==
                                                                      devoteedata
                                                                          .devoteeId
                                                                  ? false
                                                                  : true,
                                                              devotee:
                                                                  devoteedata,
                                                              devoteeIndex:
                                                                  index,
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    },
                                                    icon: const Icon(Icons.edit,
                                                        size: 20,
                                                        color: Colors.white),
                                                  )
                                                : const SizedBox(),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.79,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                      'assets/images/nsslogo.png',
                                                      scale: 35,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Text(
                                              'NILACHALA SARASWATA SANGHA, PURI',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors
                                                      .deepOrange // Text color
                                                  ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              '74TH UTKALA PRADESHIKA',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color:
                                                      Colors.black // Text color
                                                  ),
                                            ),
                                            const Text(
                                              'BHAKTA SAMMILANI, SORO - 2025',
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
                                                                      height:
                                                                          60,
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
                                                              border:
                                                                  Border.all(
                                                                color: getColorByDevotee(
                                                                    devoteedata),
                                                                width: 3,
                                                              ),
                                                              shape: BoxShape
                                                                  .circle,
                                                              image:
                                                                  DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: NetworkImage(
                                                                    devoteedata
                                                                        .profilePhotoUrl
                                                                        .toString()),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        // devoteedata.status ==
                                                        //             "paid" ||
                                                        //         devoteedata
                                                        //                 .status ==
                                                        //             "printed"
                                                        //     ? PaidTag(
                                                        //         title: "PAID",
                                                        //         status: devoteedata
                                                        //             .status
                                                        //             .toString(),
                                                        //       )
                                                        //     : devoteedata
                                                        //                 .status ==
                                                        //             "dataSubmitted"
                                                        //         ? PaidTag(
                                                        //             title:
                                                        //                 "NOT PAID",
                                                        //             status: devoteedata
                                                        //                 .status
                                                        //                 .toString(),
                                                        //           )
                                                        //         : const SizedBox()
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
                                                    _toPascalCase(devoteedata
                                                        .name
                                                        .toString()),
                                                    style: const TextStyle(
                                                      color: Colors.deepOrange,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                : const Text(""),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Flexible(
                                                    flex: 2,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: devoteedata
                                                                      .sangha !=
                                                                  null
                                                              ? Text(
                                                                  _toPascalCase(
                                                                      devoteedata
                                                                          .sangha
                                                                          .toString()),
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                )
                                                              : const Text(""),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: devoteedata
                                                                      .devoteeCode !=
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
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                )
                                                              : const Text(""),
                                                        ),
                                                        const Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            "Sri Sri Thakura Charanasrita",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        const Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            "",
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        const Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            "",
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        const Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            'Secretary',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex: 3,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
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
                                            )
                                          ],
                                        )

                                        // Row(
                                        //   children: [
                                        //     Expanded(
                                        //       flex: 1,
                                        //       child: ListView.separated(
                                        //         itemCount: 22,
                                        //         itemBuilder:
                                        //             (BuildContext context,
                                        //                 int index) {
                                        //           return SvgPicture.asset(
                                        //             'assets/images/3.svg',
                                        //             color: getColorByDevotee(
                                        //                 devoteedata),
                                        //             height: 20,
                                        //           );
                                        //         },
                                        //         separatorBuilder:
                                        //             (BuildContext context,
                                        //                 int index) {
                                        //           // This widget will be used as a separator between items.
                                        //           // You can adjust the size and appearance of the separator here.
                                        //           return const SizedBox(
                                        //               height:
                                        //                   3); // Adjust the height as needed.
                                        //         },
                                        //       ),
                                        //     ),
                                        //     Expanded(
                                        //         flex: 8,
                                        //         child: ),
                                        //     Expanded(
                                        //       child: ListView.separated(
                                        //         itemCount: 22,
                                        //         itemBuilder:
                                        //             (BuildContext context,
                                        //                 int index) {
                                        //           return SvgPicture.asset(
                                        //             'assets/images/4.svg',
                                        //             color: getColorByDevotee(
                                        //                 devoteedata),
                                        //             height: 20,
                                        //           );
                                        //         },
                                        //         separatorBuilder:
                                        //             (BuildContext context,
                                        //                 int index) {
                                        //           // This widget will be used as a separator between items.
                                        //           // You can adjust the size and appearance of the separator here.
                                        //           return const SizedBox(
                                        //               height:
                                        //                   3); // Adjust the height as needed.
                                        //         },
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        ),
                                    // Expanded(
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.only(
                                    //         bottom: 17, left: 5, right: 5),
                                    //     child: GridView.builder(
                                    //       gridDelegate:
                                    //           const SliverGridDelegateWithFixedCrossAxisCount(
                                    //         crossAxisCount:
                                    //             13, // Number of columns
                                    //         crossAxisSpacing:
                                    //             4.0, // Adjust the spacing between columns
                                    //         mainAxisSpacing:
                                    //             8.0, // Adjust the spacing between rows
                                    //       ),
                                    //       itemCount:
                                    //           13, // Change this number based on your actual requirement
                                    //       itemBuilder: (BuildContext context,
                                    //           int index) {
                                    //         return SvgPicture.asset(
                                    //           'assets/images/4.svg',
                                    //           height: 20,
                                    //           color: getColorByDevotee(
                                    //               devoteedata),
                                    //         );
                                    //       },
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
                // } else {
                // return AlertDialog(
                //   title: const Text('New Event'),
                //   content: const SingleChildScrollView(
                //     child: ListBody(
                //       children: <Widget>[
                //         Text('Are you coming Puri on 14th april ?.'),
                //       ],
                //     ),
                //   ),
                //   actions: <Widget>[
                //     TextButton(
                //       child: const Text('Yes'),
                //       onPressed: () {
                //         EventModel eventData = EventModel(
                //           devoteeCode: devoteedata.devoteeCode,
                //           devoteeId: devoteedata.devoteeId,
                //           eventAntendeeId: Uuid().v4(),
                //           inDate: '2023-04-14',
                //           outDate: '2023-04-14',
                //           eventId: '1',
                //           eventName: 'Puri',
                //           eventAttendance: true,
                //         );
                //         Navigator.of(context).pop();
                //       },
                //     ),
                //     TextButton(
                //       child: const Text('No'),
                //       onPressed: () async {
                //         EventModel eventData = EventModel(
                //           devoteeCode: devoteedata.devoteeCode,
                //           devoteeId: devoteedata.devoteeId,
                //           eventAntendeeId: Uuid().v4(),
                //           inDate: '2023-04-14',
                //           outDate: '2023-04-14',
                //           eventId: '1',
                //           eventName: 'Puri',
                //           eventAttendance: false,
                //         );
                //         await EventsAPI().addEvent(eventData);

                //         Navigator.of(context).pop();
                //       },
                //     ),
                //   ],
                // );
              }
              // },
              ),
        ),
        const SizedBox(
          height: 5,
        ),
        SmoothPageIndicator(
          controller:
              controller, // Use the same controller for SmoothPageIndicator
          count: devotees.length,
          effect: const WormEffect(
            dotColor: Colors.grey,
            activeDotColor: Colors.deepOrange,
            dotHeight: 8,
            dotWidth: 8,
            type: WormType.thinUnderground,
          ),
        ),
      ],
    );
  }
}

class PaidTag extends StatelessWidget {
  PaidTag({
    super.key,
    required this.title,
    required this.status,
  });

  String title, status;

  Text getStamp(double? fontSize, Color color) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: status == "paid" ? 50 : 80,
      left: status == "paid" ? 105 : 120,
      child: Transform.rotate(
        angle: 12,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: status == "paid"
                        ? const Color.fromARGB(255, 44, 7, 209)
                        : Colors.grey,
                    width: 4),
                borderRadius: BorderRadius.circular(4)),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: status == "paid"
                  ? getStamp(
                      40.0,
                      const Color.fromARGB(255, 44, 7, 209),
                    )
                  : getStamp(20.0, Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
