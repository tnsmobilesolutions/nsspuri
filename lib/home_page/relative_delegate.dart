import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:sammilani_delegate/enums/devotee_status.dart';
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

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
        child: SizedBox(
          height: 550,
          child: Container(
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
                color: AppBarColor,
                borderRadius: const BorderRadius.all(Radius.circular(35))),
            child: PageIndicatorContainer(
              length: devotees.length,
              align: IndicatorAlign.bottom,
              indicatorSpace: 10.0,
              padding: const EdgeInsets.all(10),
              indicatorColor: Colors.grey,
              indicatorSelectorColor: const Color.fromARGB(255, 255, 255, 255),
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
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppBarColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          width: 400,
                          height: 100,
                          child: Center(
                            child: Stack(
                              children: [
                                Positioned(
                                  child: Image.asset(
                                    'assets/images/nsslogo.png',
                                    scale: 30,
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
                                          fontSize: 14,
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
                                            fontSize: 20,
                                            color: Colors.white // Text color
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Background color of the container
                        ),
                      ),
                      Container(
                        height: 380,
                        width: 400,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        child: Column(
                          children: [
                            Center(
                              child: Row(
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
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    child: devoteedata.bloodGroup ==
                                            "Don't know"
                                        ? Container(
                                            width: 75,
                                            height: 60,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.rectangle,
                                            ),
                                          )
                                        : Expanded(
                                            child: Stack(
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
                                  flex: 2,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned(
                                        child: Container(
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
                                      ),
                                      if (devoteedata.status !=
                                          DevoteeStatus.dataSubmitted.name)
                                        Expanded(
                                          flex: 4,
                                          child: Positioned(
                                            top: 50,
                                            left: 105,
                                            child: Transform.rotate(
                                              angle: 12,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 44, 7, 209),
                                                          width: 4),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child: Text(
                                                      'PAID',
                                                      style: TextStyle(
                                                        fontSize: 40.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 44, 7, 209),
                                                      ),
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
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: devoteedata.name != null
                                  ? Text(
                                      _toCamelCase(devoteedata.name.toString()),
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
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          devoteedata.mobileNumber != null
                                              ? Text(
                                                  "Mobile  :   ${devoteedata.mobileNumber}",
                                                  style: const TextStyle(
                                                      fontSize: 16,
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
                                                  "Gender :   ${_toCamelCase(devoteedata.gender.toString())}",
                                                  style: const TextStyle(
                                                      fontSize: 16,
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
                                                  "DOB      :   ${devoteedata.dob}",
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              : const Text(
                                                  "DOB : Please Update your Date of birth"),
                                        ],
                                      ),
                                    ),
                                    const VerticalDivider(
                                      thickness: 1,
                                      color: Color.fromARGB(255, 198, 197, 197),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 90,
                                        width: 150,
                                        child: Center(
                                          child: SfBarcodeGenerator(
                                            value: '1234',
                                            symbology: QRCode(),
                                            showValue: false,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 400,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'PARICHALAK :',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
