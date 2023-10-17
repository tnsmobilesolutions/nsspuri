import 'package:flutter/material.dart';

class AddressDetailsScreen extends StatefulWidget {
  const AddressDetailsScreen({super.key});

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
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Address Details"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/white-texture.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
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
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
              ),
            ),
            SizedBox(
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
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
              ),
            ),
            SizedBox(
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
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
              ),
            ),
            SizedBox(
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
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
              ),
            ),
            SizedBox(
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
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
              ),
            ),
            SizedBox(
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
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
