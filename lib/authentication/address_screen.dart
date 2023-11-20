import 'package:flutter/material.dart';
import 'package:sammilani_delegate/API/get_devotee.dart';
import 'package:sammilani_delegate/API/put_devotee.dart';
import 'package:sammilani_delegate/home_page/home_page.dart';
import 'package:sammilani_delegate/model/address_model.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/reusable_widgets/common_style.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';

// ignore: must_be_immutable
class AddressDetailsScreen extends StatefulWidget {
  AddressDetailsScreen({super.key, required this.devotee});
  DevoteeModel devotee;
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
            backgroundColor: AppBarColor,
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
                    onPressed: () async {
                      await GetDevoteeAPI()
                          .loginDevotee(widget.devotee.uid.toString());
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return HomePage();
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
                    style: Theme.of(context).textTheme.displaySmall,
                    textCapitalization: TextCapitalization.words,
                    controller: addressLine1Controller,
                    onSaved: (newValue) => addressLine1Controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter address line 1';
                      }
                      return null;
                    },
                    decoration: CommonStyle.textFieldStyle(
                        labelTextStr: "Address Line 1",
                        hintTextStr: "Enter Adddress Line 1"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  style: Theme.of(context).textTheme.displaySmall,
                  controller: addressLine2Controller,
                  onSaved: (newValue) => addressLine2Controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address line 2';
                    }
                    return null;
                  },
                  decoration: CommonStyle.textFieldStyle(
                      labelTextStr: "Address Line 2",
                      hintTextStr: "Enter Address Line 2"),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  style: Theme.of(context).textTheme.displaySmall,
                  controller: cityController,
                  onSaved: (newValue) => cityController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter city name';
                    }
                    return null;
                  },
                  decoration: CommonStyle.textFieldStyle(
                      labelTextStr: "City Name",
                      hintTextStr: "Enter City Name"),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  style: Theme.of(context).textTheme.displaySmall,
                  controller: stateController,
                  onSaved: (newValue) => stateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter state name';
                    }
                    return null;
                  },
                  decoration: CommonStyle.textFieldStyle(
                      labelTextStr: "State Name",
                      hintTextStr: "Enter State Name"),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  style: Theme.of(context).textTheme.displaySmall,
                  controller: countryController,
                  onSaved: (newValue) => addressLine1Controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter country name';
                    }
                    return null;
                  },
                  decoration: CommonStyle.textFieldStyle(
                      labelTextStr: "Country Name",
                      hintTextStr: "Enter Country Name"),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  style: Theme.of(context).textTheme.displaySmall,
                  controller: postalCodeController,
                  onSaved: (newValue) => postalCodeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter postal code';
                    }
                    return null;
                  },
                  decoration: CommonStyle.textFieldStyle(
                      labelTextStr: "PIN Code", hintTextStr: "Enter PIN Code"),
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
                          devoteeId: widget.devotee.devoteeId,
                          uid: widget.devotee.uid,
                          emailId: widget.devotee.emailId,
                          createdById: widget.devotee.devoteeId,
                          bloodGroup: widget.devotee.bloodGroup,
                          name: widget.devotee.name,
                          gender: widget.devotee.gender,
                          profilePhotoUrl: widget.devotee.profilePhotoUrl,
                          sangha: widget.devotee.sangha,
                          dob: widget.devotee.dob,
                          mobileNumber: widget.devotee.mobileNumber,
                          status: "dataSubmitted",
                          isAdmin: false,
                          address: AddressModel(
                              addressLine1: addressLine1Controller.text,
                              addressLine2: addressLine2Controller.text,
                              city: cityController.text,
                              country: countryController.text,
                              postalCode:
                                  int.tryParse(postalCodeController.text),
                              state: stateController.text));
                      final response = await PutDevoteeAPI().updateDevotee(
                          devoteeAddress, widget.devotee.devoteeId.toString());
                      if (response["statusCode"] == 200) {
                        await GetDevoteeAPI()
                            .loginDevotee(widget.devotee.uid.toString());
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
