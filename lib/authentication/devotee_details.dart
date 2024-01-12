// ignore_for_file: avoid_print

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sammilani_delegate/API/get_devotee.dart';
import 'package:sammilani_delegate/API/put_devotee.dart';
import 'package:sammilani_delegate/authentication/address_screen.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/reusable_widgets/common_style.dart';
import 'package:sammilani_delegate/sangha_list/sangha_list.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';
import 'package:sammilani_delegate/utilities/custom_calender.dart';

// ignore: depend_on_referenced_packages

// ignore: must_be_immutable
class DevoteeDetailsPage extends StatefulWidget {
  DevoteeDetailsPage({Key? key, required this.devotee}) : super(key: key);

  DevoteeModel devotee;
  // get currentUser => null;

  @override
  State<DevoteeDetailsPage> createState() => _DevoteeDetailsPageState();
}

class _DevoteeDetailsPageState extends State<DevoteeDetailsPage> {
  TextEditingController dobController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _showCustomCalendarDialog(BuildContext context) async {
    final selectedDate = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Select Date",
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.deepOrange,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              content: CustomCalender(
                forEdit: false,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        );
      },
    );

    if (selectedDate != null) {
      dobController.text = selectedDate;
    }
  }

  FocusNode focusNode = FocusNode();

  String _formatDOB(String dob) {
    String dateString = dob;
    DateTime dateTime = DateFormat('dd/MMM/yyyy', 'en').parse(dateString);
    String formattedDate = DateFormat('y-MM-dd').format(dateTime);
    return formattedDate;
  }

  DateTime? parseDate(String value) {
    try {
      return DateFormat('yyyy-MM-dd').parseStrict(value);
    } catch (e) {
      print('Error parsing date: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppBarColor,
          automaticallyImplyLeading: false,
          title: const Text('Devotee Details'),
          centerTitle: true,
        ),
        backgroundColor: ScaffoldBackgroundColor,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: dobController,
                              decoration: CommonStyle.textFieldStyle(
                                labelTextStr: "Date Of Birth",
                                hintTextStr: "Enter Date Of Birth (Optional)",
                                suffixIcon: const Icon(
                                  Icons.calendar_view_month_rounded,
                                  color: Colors.deepOrange,
                                ),
                              ),
                              readOnly: true,
                              onTap: () => _showCustomCalendarDialog(context),
                              validator: (value) {
                                if (value != null && value.isNotEmpty) {
                                  // Check if the value is a valid date format
                                  DateTime? parsedDate = parseDate(value);

                                  if (parsedDate == null) {
                                    // Handle the case where the date cannot be parsed
                                    return 'Invalid date format';
                                  }
                                }
                                // Return null for valid input or empty input (since it's optional)
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90)),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          showDialog(
                            context: context,
                            barrierDismissible:
                                false, // Prevent dismissing by tapping outside
                            builder: (BuildContext context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );

                          // Navigate to the next screen
                          await Future.delayed(
                              const Duration(seconds: 1)); // Simulating a dela
                          try {
                            DevoteeModel newDevotee = DevoteeModel(
                              dob: _formatDOB(dobController.text),
                              status: "dataSubmitted",
                            );

                            final response = await PutDevoteeAPI()
                                .updateDevotee(newDevotee,
                                    widget.devotee.devoteeId.toString());
                            if (response["statusCode"] == 200) {
                              if (context.mounted) {
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return AddressDetailsScreen(
                                        devotee: newDevotee);
                                  }),
                                );
                              }
                            } else {
                              if (context.mounted) {
                                Navigator.of(context)
                                    .pop(); // Close the circular progress indicator
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('devotee update issue')));
                              }
                            }
                          } catch (e) {
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                            print(e);
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return ButtonColor;
                              }
                              return ButtonColor;
                            }),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(90)))),
                        child: const Text(
                          'Next',
                        ),

                        //Row
                      ),
                    ),
                  ]),
            ),
          ),
        )),
      ),
    );
  }
}
