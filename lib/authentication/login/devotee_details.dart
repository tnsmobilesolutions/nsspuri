import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:sammilani_delegate/home_page/home_page.dart';


// ignore: depend_on_referenced_packages

// ignore: must_be_immutable
class DevoteeDetailsPage extends StatefulWidget {
  DevoteeDetailsPage({
    Key? key,
  }) : super(key: key);

  get currentUser => null;

  @override
  State<DevoteeDetailsPage> createState() => _DevoteeDetailsPageState();
}

class _DevoteeDetailsPageState extends State<DevoteeDetailsPage> {
  String? birthDistrict;
  String? profileImage;
  XFile? previewImage;
  List<String> bloodGrouplist = <String>[
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
  ];

  get districtList => null;
  void selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    setState(() {
      previewImage = pickedFile;
    });
  }

  void showPhotoOptions() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Upload Profile Picture"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(ImageSource.gallery);
                  },
                  leading: const Icon(Icons.photo_album),
                  title: const Text("Select from Gallery"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(ImageSource.camera);
                  },
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Take a photo"),
                ),
              ],
            ),
          );
        });
  }

  final nameController = TextEditingController();
  // final emailController = TextEditingController();
  final mobileController = TextEditingController();

  String? dropdownValue;

  final TextEditingController emailController = TextEditingController();
   final TextEditingController genderController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  final TextEditingController sanghaController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  //return image name
  // String getImageName(XFile image) {
  //   return image.path.split("/").last;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Text('Devotee Details'),
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
        child: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      
                      ElevatedButton(onPressed: () {
                         Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const HomePage()),
  );
                        
                      }, child: const Text('Skip')),
                    ],
                  ),
                  CupertinoButton(
                    onPressed: () {
                      showPhotoOptions();
                    },
                    child: CircleAvatar(
                     
                      radius: 60,
                      child: const Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20.0,
                          child: Icon(
                            Icons.camera_alt,
                            size: 25.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(width: 15),
                        Expanded(
                          child: SizedBox(
                            height: 60,
                           width: MediaQuery.of(context).size.width,
                            child: DropdownButtonFormField(
                              
                                     decoration: InputDecoration(
      
   
      labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.grey.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
          
                              
                              
                                          
                              value: dropdownValue,
                                          
                              elevation: 16,
                              hint: const Text('Select BloodGroup'),
                              // style: const TextStyle(color: Colors.deepPurple),
                                          
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownValue = value;
                                });
                              },
                              items: bloodGrouplist
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: nameController,
                    onSaved: (newValue) => nameController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]"))
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                          decoration: InputDecoration(
      
      labelText: "Name",
      labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.grey.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
          
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: emailController,
                    onSaved: (newValue) => emailController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]"))
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Email';
                      }
                      return null;
                    },
                           decoration: InputDecoration(
      
      labelText: " Email",
      labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.grey.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
          
                  ),
              
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: mobileController,
                    onSaved: (newValue) => mobileController,
                    validator: (value) {
                      RegExp regex = RegExp(r'^.{10}$');
                      if (value!.isEmpty) {
                        return ("Please enter Phone Number");
                      }
                      if (!regex.hasMatch(value) && value.length != 10) {
                        return ("Enter 10 Digit Mobile Number");
                      }
                      return null;
                    },
                            decoration: InputDecoration(
      
      labelText: " Mobile number",
      labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.grey.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
          
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: genderController,
                    onSaved: (newValue) => genderController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]"))
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter gender';
                      }
                      return null;
                    },
                           decoration: InputDecoration(
      
      labelText: " Gender",
      labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.grey.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
          
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: sanghaController,
                            decoration: InputDecoration(
      
      labelText: " Sangha",
      labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.grey.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
          
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: sanghaController,
                          decoration: InputDecoration(
      
      labelText: " Permanent Address",
      labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.grey.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
          
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: cityController,
                            decoration: InputDecoration(
      
      labelText:  "Present Address",
      labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.grey.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
          
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: professionController,
                           decoration: InputDecoration(
      
      labelText: " Profession",
      labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.grey.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
          
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                 
                   ElevatedButton(
                    onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HomePage()),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                      textStyle: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.normal),
                    ),
                    child: const Text('Signup'),
                  ),
              
                  //Row
              
                  const SizedBox(height: 20),
                ]),
              )),
        ),
      ),
    );
  }
}



