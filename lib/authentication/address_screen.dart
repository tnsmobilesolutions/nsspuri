import 'package:flutter/material.dart';
import 'package:sammilani_delegate/API/put_devotee.dart';
import 'package:sammilani_delegate/home_page/home_page.dart';
import 'package:sammilani_delegate/model/address_model.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';

// ignore: must_be_immutable
class AddressDetailsScreen extends StatefulWidget {
  AddressDetailsScreen({super.key,required this.devoteeId});
  String devoteeId;
  @override
  State<AddressDetailsScreen> createState() => _AddressDetailsScreenState();
}

class _AddressDetailsScreenState extends State<AddressDetailsScreen> {
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final postalCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ScaffoldBackgroundColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: ScaffoldBackgroundColor,
            centerTitle: true,
            elevation: .4,
            title: Text(
              'Address details',
              style: Theme.of(context).textTheme.titleMedium,
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return HomePage(
                          );
                        },
                      ));
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(fontSize: 16, color: ButtonColor),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: TextFormField(
                    controller: addressLine1Controller,
                    onSaved: (newValue) => addressLine1Controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter address line 1';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Address line 1",
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: addressLine2Controller,
                  onSaved: (newValue) => addressLine2Controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address line 2';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Address line 2",
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: cityController,
                  onSaved: (newValue) => cityController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter city name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "City name",
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: stateController,
                  onSaved: (newValue) => stateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter state name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "State name",
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: countryController,
                  onSaved: (newValue) => addressLine1Controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter country name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Country name",
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: postalCodeController,
                  onSaved: (newValue) => postalCodeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter postal code';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Postal code",
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
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
                          const Duration(seconds: 1)); // Simulating a delay
                      DevoteeModel devoteeAddress = DevoteeModel(
                          address: AddressModel(
                              addressLine1: addressLine1Controller.text,
                              addressLine2: addressLine2Controller.text,
                              city: cityController.text,
                              country: countryController.text,
                              postalCode:
                                  int.tryParse(postalCodeController.text),
                              state: stateController.text));
                      final response = await PutDevoteeAPI()
                          .updateDevotee(devoteeAddress, widget.devoteeId);
                      if (response["statusCode"] == 200) {
                        Navigator.of(context)
                            .pop(); // Close the circular progress indicator
                        // ignore: use_build_context_synchronously
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return HomePage();
                          },
                        ));
                      } else {
                        Navigator.of(context)
                            .pop(); // Close the circular progress indicator
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Address update failed')));
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60)))),
                    child: const Text(
                      'Signup',
                    ),

                    //Row
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
