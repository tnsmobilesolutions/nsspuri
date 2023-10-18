import 'package:flutter/material.dart';
import 'package:sammilani_delegate/API/put_devotee.dart';
import 'package:sammilani_delegate/home_page/home_page.dart';
import 'package:sammilani_delegate/model/address_model.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';

// ignore: must_be_immutable
class AddressDetailsScreen extends StatefulWidget {
  AddressDetailsScreen({super.key, required this.devoteeId});
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Address Details",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/white-texture.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 250),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return HomePage(
                            devoteeId: widget.devoteeId,
                          );
                        },
                      ));
                    },
                    child: const Text(
                      'Skip >',
                      style: TextStyle(fontSize: 16, color: Colors.deepOrange),
                    ),
                  ),
                ),
                TextFormField(
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
                    labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.grey.withOpacity(0.3),
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
                    labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.grey.withOpacity(0.3),
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
                    labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.grey.withOpacity(0.3),
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
                    labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.grey.withOpacity(0.3),
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
                    labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.grey.withOpacity(0.3),
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
                    labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.grey.withOpacity(0.3),
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
                  child: ElevatedButton(
                    onPressed: () async {
                      DevoteeModel devoteeAddress = DevoteeModel(
                          address: AddressModel(
                              addressLine1: addressLine1Controller.text,
                              addressLine2: addressLine2Controller.text,
                              city: cityController.text,
                              country: countryController.text,
                              pincode: postalCodeController.text,
                              state: stateController.text));
                      final response = await PutDevoteeAPI()
                          .updateDevotee(devoteeAddress, widget.devoteeId);
                      if (response["statusCode"] == 200) {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return HomePage(devoteeId: widget.devoteeId);
                          },
                        ));
                      }
                    },

                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.deepOrange;
                          }
                          return Colors.deepOrange;
                        }),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(90)))),
                    child: const Text(
                      'Signup',
                      style: TextStyle(fontSize: 18),
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
