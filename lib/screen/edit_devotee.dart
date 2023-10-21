import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sammilani_delegate/API/put_devotee.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sammilani_delegate/home_page/home_page.dart';
import 'package:sammilani_delegate/model/address_model.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/sangha_list/sangha_list.dart';

// ignore: depend_on_referenced_packages

// ignore: must_be_immutable
class EditDevoteeDetailsPage extends StatefulWidget {
  EditDevoteeDetailsPage({
    Key? key,
    required this.devotee,
  }) : super(key: key);
  DevoteeModel devotee;
  get currentUser => null;

  @override
  State<EditDevoteeDetailsPage> createState() => _EditDevoteeDetailsPageState();
}

class _EditDevoteeDetailsPageState extends State<EditDevoteeDetailsPage> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final sanghaController = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? bloodGroupController;

  List gender = ["Male", "Female"];
  int genderController = 0;
  String? profileURL;

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

  @override
  void initState() {
    super.initState();
    nameController.text = widget.devotee.name ?? "";
    mobileController.text = widget.devotee.mobileNumber ?? "";
    sanghaController.text = widget.devotee.sangha ?? "";
    dateinput.text = widget.devotee.dob ?? "";
    bloodGroupController = widget.devotee.bloodGroup ?? bloodGroupController;
    profileURL = widget.devotee.profilePhotoUrl ?? "";
  }

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

  Future<String?> uploadImageToFirebaseStorage(XFile image, String name) async {
    // print('**************${getImageName(image)}**************');
    Reference storage =
        FirebaseStorage.instance.ref('${name}/${getImageName(image)}');
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
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                          : Image.network(profileURL.toString()).image,
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
                      color: Colors.deepOrange,
                    ),
                    // hintText: 'Enter Your Mobile Number',
                    labelText: 'Mobile Number'),
              ),
              const SizedBox(
                height: 20,
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
                              fillColor:
                                  MaterialStateProperty.all(Colors.deepOrange),
                              value: 0,
                              groupValue: genderController,
                              title: const Text("Male",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black)),
                              onChanged: (newValue) => setState(
                                  () => genderController = newValue ?? 0),
                              activeColor: Colors.deepOrange,
                              // Set the unselected color to blue
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
                              fillColor:
                                  MaterialStateProperty.all(Colors.deepOrange),
                              title: const Text("Female",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black)),
                              onChanged: (newValue) {
                                setState(() {
                                  genderController = newValue ?? 0;
                                });
                              },
                              activeColor: Colors.deepOrange,
                              // Set the unselected color to blue
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
                height: 20,
              ),
              GestureDetector(
                child: TextField(
                  style: const TextStyle(color: Colors.black),
                  controller: dateinput, //editing controller of this TextField
                  decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      icon: Icon(Icons.calendar_today),
                      iconColor: Colors.deepOrange, //icon of text field
                      labelText: "Enter Date Of Birth" //label text of field
                      ),
                  readOnly:
                      true, //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        initialEntryMode: DatePickerEntryMode
                            .calendarOnly, // Hide edit button
                        fieldHintText: 'dd-MM-yyyy',
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            1900), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2040));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        dateinput.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.bloodtype, color: Color(0xFFfa6e0f)),
                  const SizedBox(width: 15),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: bloodGroupController,

                      elevation: 16,
                      hint: const Text('Select BloodGroup'),
                      // style: const TextStyle(color: Colors.deepPurple),

                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          bloodGroupController = value!;
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
              const SizedBox(
                height: 20,
              ),
              TypeAheadFormField(
                noItemsFoundBuilder: (context) => const SizedBox(
                  height: 70,
                  child: Center(
                    child: Text('No Item Found'),
                  ),
                ),
                suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                    color: Colors.white,
                    elevation: 5,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                debounceDuration: const Duration(milliseconds: 400),
                textFieldConfiguration: TextFieldConfiguration(
                    controller: sanghaController,
                    decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                          35.0,
                        )),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(35.0),
                            ),
                            borderSide: BorderSide(color: Colors.transparent)),
                        hintText: "Sangha name",
                        contentPadding: const EdgeInsets.only(top: 4, left: 10),
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 16),
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search, color: Colors.grey)),

                        // fillColor: Colors.white,
                        filled: true)),
                suggestionsCallback: (value) {
                  return SanghaList.getSuggestions(value);
                },
                itemBuilder: (context, String suggestion) {
                  return Row(
                    children: [
                      const SizedBox(
                        width: 10,
                        height: 50,
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            suggestion,
                            maxLines: 2,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      )
                    ],
                  );
                },
                onSuggestionSelected: (String suggestion) {
                  setState(() {
                    sanghaController.text = suggestion;
                  });
                },
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(90)),
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
                    await Future.delayed(
                        const Duration(seconds: 1)); // Simulating a delay
                    try {
                      profileURL = previewImage != null
                          ? await uploadImageToFirebaseStorage(
                              previewImage as XFile, nameController.text)
                          : null;
                      DevoteeModel updateDevotee = DevoteeModel(
                          bloodGroup: bloodGroupController,
                          name: nameController.text,
                          gender: gender[genderController],
                          profilePhotoUrl: profileURL,
                          sangha: sanghaController.text,
                          dob: dateinput.text,
                          mobileNumber: mobileController.text,
                          updatedAt: DateTime.now().toString(),
                          address: AddressModel());

                      final response = await PutDevoteeAPI().updateDevotee(
                          updateDevotee, widget.devotee.devoteeId.toString());
                      if (response["statusCode"] == 200) {
                        // Show a circular progress indicator while navigating
                        // ignore: use_build_context_synchronously
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
                        Navigator.of(context)
                            .pop(); // Close the circular progress indicator
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HomePage(uid: widget.devotee.uid.toString()),
                            ));
                      } else {
                        Navigator.of(context)
                            .pop(); // Close the circular progress indicator
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('devotee update issue')));
                      }
                    } catch (e) {
                      Navigator.of(context)
                          .pop(); // Close the circular progress indicator
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                      print(e);
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(90)))),
                  child: const Text(
                    'Next >',
                    style: TextStyle(fontSize: 18),
                  ),

                  //Row
                ),
              ),
            ]),
          ),
        )),
      ),
    );
  }
}
