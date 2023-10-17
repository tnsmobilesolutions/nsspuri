import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sammilani_delegate/API/post_devotee.dart';
import 'package:sammilani_delegate/home_page/home_page.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/sangha_list/sangha_list.dart';

// ignore: depend_on_referenced_packages

// ignore: must_be_immutable
class DevoteeDetailsPage extends StatefulWidget {
  const DevoteeDetailsPage({
    Key? key,
  }) : super(key: key);

  get currentUser => null;

  @override
  State<DevoteeDetailsPage> createState() => _DevoteeDetailsPageState();
}

class _DevoteeDetailsPageState extends State<DevoteeDetailsPage> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final professionController = TextEditingController();
  final permanentAdressController = TextEditingController();
  final presentAddressController = TextEditingController();
  final sanghaController = TextEditingController();
  String? bloodGroupController;
  List gender = ["Male", "Female"];
  int genderController = -1;
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

  String? select;

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              print(value);
              select = value;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  Future<String?> uploadImageToFirebaseStorage(XFile image) async {
    // print('**************${getImageName(image)}**************');
    Reference storage = FirebaseStorage.instance
        .ref('${widget.currentUser?.name}/${getImageName(image)}');
    await storage.putFile(File(image.path));
    return await storage.getDownloadURL();
  }

  // return image name
  String getImageName(XFile image) {
    return image.path.split("/").last;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const HomePage();
                        },
                      ));
                    },
                    child: const Text(
                      'Skip >',
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                  ),
                ],
              ),
              CupertinoButton(
                onPressed: () {
                  showPhotoOptions();
                },
                child: CircleAvatar(
                  backgroundColor: const Color(0xFFfa6e0f),
                  backgroundImage:
                      previewImage != null && previewImage!.path.isNotEmpty
                          ? Image.file(
                              File('${previewImage?.path}'),
                              fit: BoxFit.cover,
                            ).image
                          : null,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelStyle:
                            TextStyle(color: Colors.grey.withOpacity(0.3)),
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        fillColor: Colors.grey.withOpacity(0.3),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none)),
                      ),

                      value: bloodGroupController,

                      elevation: 16,
                      hint: const Text('Select BloodGroup'),
                      // style: const TextStyle(color: Colors.deepPurple),

                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          bloodGroupController = value;
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
                decoration: InputDecoration(
                  labelText: "Name",
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
              const SizedBox(
                height: 12,
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
                  labelText: " Mobile Number",
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
              const SizedBox(
                height: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text('Gender',
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: RadioListTile(
                              fillColor: MaterialStateProperty.all(Colors.blue),
                              value: 0,
                              groupValue: genderController,
                              title: const Text("Male",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black)),
                              onChanged: (newValue) => setState(
                                  () => genderController = newValue ?? 0),
                              activeColor: Colors
                                  .blue, // Set the unselected color to blue
                              selectedTileColor:
                                  Colors.deepOrange, // Set the selected color
                              selected: false,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: RadioListTile(
                              value: 1,
                              groupValue: genderController,
                              fillColor: MaterialStateProperty.all(Colors.blue),
                              title: const Text("Female",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black)),
                              onChanged: (newValue) {
                                setState(() {
                                  genderController = newValue ?? 0;
                                });
                              },
                              activeColor: Colors
                                  .blue, // Set the unselected color to blue
                              selectedTileColor:
                                  Colors.deepOrange, // Set the selected color
                              selected: false,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: TypeAheadField(
                    noItemsFoundBuilder: (context) => const SizedBox(
                      height: 50,
                      child: Center(
                        child: Text('No Item Found'),
                      ),
                    ),
                    suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                        color: Colors.white,
                        elevation: 4.0,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        )),
                    debounceDuration: const Duration(milliseconds: 400),
                    textFieldConfiguration: TextFieldConfiguration(
                        decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                              15.0,
                            )),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                                borderSide: BorderSide(color: Colors.black)),
                            hintText: "Search",
                            contentPadding:
                                const EdgeInsets.only(top: 4, left: 10),
                            hintStyle: const TextStyle(
                                color: Colors.grey, fontSize: 14),
                            suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.search,
                                    color: Colors.grey)),
                            fillColor: Colors.white,
                            filled: true)),
                    suggestionsCallback: (value) {
                      return StateService.getSuggestions(value);
                    },
                    itemBuilder: (context, String suggestion) {
                      return Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                suggestion,
                                maxLines: 1,
                                // style: TextStyle(color: Colors.red),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    onSuggestionSelected: (String suggestion) {
                      setState(() {
                        var userSelected = suggestion;
                      });
                    },
                  )),
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
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none)),
                ),
              ),
              const SizedBox(
                height: 12,
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
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none)),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(90)),
                  child: ElevatedButton(
                    onPressed: () async {
                      String? profileURL = previewImage != null
                          ? await uploadImageToFirebaseStorage(
                              previewImage as XFile)
                          : null;
                      DevoteeModel newDevotee = DevoteeModel(
                          bloodGroup: bloodGroupController,
                          devoteeName: nameController.text,
                          gender: gender[genderController],
                          mobileNumber: mobileController.text,
                          permanentAddress: permanentAdressController.text,
                          presentAddress: presentAddressController.text,
                          profession: professionController.text,
                          profileImageURL: profileURL);
                      await DevoteeAPI().addDevotee(newDevotee);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    },
                    child: Text(
                      'Signup',
                      style: TextStyle(fontSize: 18),
                    ),
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

                    //Row
                  ))
            ]),
          )),
        ),
      ),
    );
  }
}
