import 'dart:io';
import 'dart:ui';



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';



// ignore: depend_on_referenced_packages


// ignore: must_be_immutable
class DevoteeDetailsPage extends StatefulWidget {
  DevoteeDetailsPage({Key? key, }) : super(key: key);
  
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


  final TextEditingController cityController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  final TextEditingController sanghaController = TextEditingController();


  //return image name
  String getImageName(XFile image) {
    return image.path.split("/").last;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Edit Profile'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CupertinoButton(
              onPressed: () {
                showPhotoOptions();
              },
              child: CircleAvatar(
                backgroundColor: const Color(0xFF530E62),
                backgroundImage:
                    previewImage != null && previewImage!.path.isNotEmpty
                        ? Image.file(
                            File('${previewImage?.path}'),
                            fit: BoxFit.cover,
                          ).image
                        : NetworkImage('${widget.currentUser?.profilepicURL}'),
                radius: 60,
                child: const Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20.0,
                    child: Icon(
                      Icons.camera_alt,
                      size: 25.0,
                      color: Color(0xFF404040),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.bloodtype,  color: Colors.purple,),
                const SizedBox(width: 15),
                Expanded(
                  child: DropdownButtonFormField(
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
                   items: bloodGrouplist.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
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
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: Colors.purple,
                  ),
                  // hintText: 'Name',
                  labelText: "Name"),
            ),
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
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: Colors.purple,
                  ),
                  // hintText: 'Name',
                  labelText: "Gender"),
            ),
            const SizedBox(height: 10),
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
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.phone,
                    color: Colors.purple,
                  ),
                  // hintText: 'Enter Your Mobile Number',
                  labelText: 'Mobile Number'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: sanghaController,
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.temple_buddhist,
                    color: Colors.purple,
                  ),
                  labelText: "Sangha"),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cityController,
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.location_city_rounded,
                    color: Colors.purple,
                  ),
                  labelText: "City"),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: professionController,
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.work,
                    color: Colors.purple,
                  ),
                  labelText: "Profession"),
            ),
            const SizedBox(height: 10),

            //Row

            const SizedBox(height: 20),
          
          ]),
        ),
      )),
    );
  }
}

 