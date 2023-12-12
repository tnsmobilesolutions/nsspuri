import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
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
      return Colors.red;
    } else if (devotee.dob != "" && devotee.dob != null) {
      if (isValidDateFormat(devotee.dob.toString())) {
        if (devotee.isSpeciallyAbled == true ||
            calculateAge(DateTime.parse(devotee.dob.toString())) >= 60) {
          return Colors.purple;
        } else if (calculateAge(DateTime.parse(devotee.dob.toString())) <= 18) {
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
      return Colors.pink;
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
                          color: getColorByDevotee(devoteedata),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 194, 202, 218),
                              spreadRadius: 4,
                              blurRadius: 8,
                            ),
                          ],
                          border: Border.all(
                            width: 10,
                            color: const Color.fromARGB(255, 233, 233, 233),
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(35))),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Image.asset(
                                      'assets/images/nsslogo.png',
                                      scale: 50,
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  flex: 6,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'JAYAGURU',
                                        style: TextStyle(
                                          fontSize: 12,
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
                                          fontSize: 9,
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
                                            fontSize: 14,
                                            color: Colors.white // Text color
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Image.asset(
                                      'assets/images/nsslogo.png',
                                      scale: 50,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 1.9,
                            width: MediaQuery.of(context).size.width / 1.1,
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
                                      child: Text(
                                        'DELEGATE CARD',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    // const SizedBox(
                                    //   width: 50,
                                    // ),
                                    Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        width: 30,
                                        height: 30,
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
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            child: devoteedata.bloodGroup ==
                                                        "Don't know" ||
                                                    devoteedata.bloodGroup ==
                                                        null
                                                ? Container(
                                                    width: 75,
                                                    height: 60,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.rectangle,
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
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                          flex: 8,
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Positioned(
                                                child: Container(
                                                  width: 145,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              212,
                                                              212,
                                                              212),
                                                      width: 1,
                                                    ),
                                                    shape: BoxShape
                                                        .rectangle, // This makes the container circular
                                                    image: DecorationImage(
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
                                                      .dataSubmitted.name)
                                                Positioned(
                                                  top: 50,
                                                  left: 105,
                                                  child: Transform.rotate(
                                                    angle: 12,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    44,
                                                                    7,
                                                                    209),
                                                                width: 4),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4)),
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  4.0),
                                                          child: Text(
                                                            'PAID',
                                                            style: TextStyle(
                                                              fontSize: 40.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color
                                                                  .fromARGB(
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
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                devoteedata.name != null
                                    ? Text(
                                        _toPascalCase(
                                            devoteedata.name.toString()),
                                        style: const TextStyle(
                                          color: Colors.deepOrange,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : const Text(""),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: devoteedata.sangha != null
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0, right: 0),
                                              child: Center(
                                                child: Text(
                                                  "${devoteedata.sangha}",
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            )
                                          : const Text(""),
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: Container(
                                        padding: const EdgeInsets.all(0),
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4.8,
                                        width:
                                            MediaQuery.of(context).size.height /
                                                4.8,
                                        child: SfBarcodeGenerator(
                                          value: devoteedata.devoteeCode
                                              .toString(),
                                          symbology: QRCode(),
                                          showValue: false,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: const Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'SAMPADAK:',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
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
