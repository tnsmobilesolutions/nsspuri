import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sammilani_delegate/API/get_devotee.dart';
import 'package:sammilani_delegate/API/put_devotee.dart';
import 'package:sammilani_delegate/authentication/address_screen.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/reusable_widgets/common_style.dart';
import 'package:sammilani_delegate/sangha_list/sangha_list.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';

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
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController sanghaController = TextEditingController();
  TextEditingController dateInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String name = "";
  String? bloodGroupController;
  DateTime selectedDate = DateTime.now();
  List<String>? sanghaSuggestions = [];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        String formattedDate = DateFormat('y-MM-dd').format(selectedDate);
        dateInputController.text = formattedDate;
      });
  }

  List gender = ["Male", "Female"];
  int genderController = 0;

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
    "Don't know"
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
            title: Text(
              "Upload Profile Picture",
              style: TextStyle(
                  color: Color.fromARGB(255, 135, 135, 135), fontSize: 16),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(ImageSource.gallery);
                  },
                  leading: const Icon(Icons.photo_album),
                  title: Text(
                    "Select from Gallery",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(ImageSource.camera);
                  },
                  leading: const Icon(Icons.camera_alt),
                  title: Text(
                    "Take a photo",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
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

  void initState() {
    dateInputController.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                    CupertinoButton(
                      onPressed: () {
                        showPhotoOptions();
                      },
                      child: CircleAvatar(
                        radius: 50,
                        child: CircleAvatar(
                          backgroundImage: previewImage != null &&
                                  previewImage!.path.isNotEmpty
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
                              radius: 15.0,
                              child: Icon(
                                Icons.camera_alt,
                                size: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      style: Theme.of(context).textTheme.displaySmall,
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      onSaved: (newValue) => nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                      decoration: CommonStyle.textFieldStyle(
                          labelTextStr: "Name", hintTextStr: "Enter Name"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: Theme.of(context).textTheme.displaySmall,
                      keyboardType: TextInputType.phone,
                      controller: mobileController,
                      onSaved: (newValue) => mobileController,
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{10}$');
                        // if (value!.isEmpty) {
                        //   return ("Please enter Phone Number");
                        // }
                        if ((value ?? '').isNotEmpty &&
                            !regex.hasMatch(value ?? '') &&
                            value?.length != 10) {
                          return ("Enter 10 Digit Mobile Number");
                        }
                        return null;
                      },
                      decoration: CommonStyle.textFieldStyle(
                          labelTextStr: "Mobile Number",
                          hintTextStr: "Enter Mobile Number"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Gender',
                        ),
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: RadioListTile(
                                    value: 0,
                                    groupValue: genderController,
                                    title: Text(
                                      "Male",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    onChanged: (newValue) => setState(
                                        () => genderController = newValue ?? 0),
                                    activeColor: RadioButtonColor,
                                    // Set the unselected color to blue
                                    selectedTileColor:
                                        RadioButtonColor, // Set the selected color
                                    selected: false,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: RadioListTile(
                                    value: 1,
                                    groupValue: genderController,

                                    title: Text(
                                      "Female",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    onChanged: (newValue) {
                                      setState(() {
                                        genderController = newValue ?? 0;
                                      });
                                    },
                                    activeColor: RadioButtonColor,
                                    // Set the unselected color to blue
                                    selectedTileColor:
                                        RadioButtonColor, // Set the selected color
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
                        style: Theme.of(context).textTheme.displaySmall,
                        controller:
                            dateInputController, //editing controller of this TextField
                        decoration: CommonStyle.textFieldStyle(
                            labelTextStr: "Date Of Birth",
                            hintTextStr: "Select your Date of birth"),
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () => _selectDate(context),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DropdownButtonFormField(
                            style: Theme.of(context).textTheme.displaySmall,
                            value: bloodGroupController,

                            elevation: 16,
                            decoration: CommonStyle.textFieldStyle(
                                labelTextStr: "Blood Group",
                                hintTextStr: "Enter Blood Group"),

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
                          color: SuggestionBoxColor,
                          elevation: 5,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )),
                      debounceDuration: const Duration(milliseconds: 400),
                      textFieldConfiguration: TextFieldConfiguration(
                        style: Theme.of(context).textTheme.displaySmall,
                        controller: sanghaController,
                        decoration: CommonStyle.textFieldStyle(
                            labelTextStr: "Sangha Name",
                            hintTextStr: "Enter Sangha Name"),
                      ),
                      validator: (value) {
                        if ((value ?? '').isNotEmpty &&
                            sanghaSuggestions?.indexWhere(
                                    (element) => element == value) ==
                                -1) {
                          return 'Please choose a sangha from the list';
                        }
                        return null;
                      },
                      suggestionsCallback: (value) async {
                        final sanghaList = await GetDevoteeAPI().getAllSangha();
                        final sanghaNames =
                            sanghaList?.map((e) => e.sanghaName ?? '');
                        setState(() {
                          sanghaSuggestions = sanghaNames?.toList();
                        });
                        return SanghaList.getSuggestions(
                            value, sanghaNames?.toList());
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
                                  maxLines: 10,
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
                            String? profileURL = previewImage != null
                                ? await uploadImageToFirebaseStorage(
                                    previewImage as XFile, nameController.text)
                                : null;
                            DevoteeModel newDevotee = DevoteeModel(
                              devoteeId: widget.devotee.devoteeId,
                              uid: widget.devotee.uid,
                              emailId: widget.devotee.emailId,
                              createdById: widget.devotee.devoteeId,
                              bloodGroup: bloodGroupController,
                              name: nameController.text,
                              gender: gender[genderController],
                              profilePhotoUrl: profileURL,
                              sangha: sanghaController.text,
                              dob: dateInputController.text,
                              mobileNumber: mobileController.text,
                              status: "dataSubmitted",
                            );

                            final response = await PutDevoteeAPI()
                                .updateDevotee(newDevotee,
                                    widget.devotee.devoteeId.toString());
                            if (response["statusCode"] == 200) {
                              Navigator.of(context)
                                  .pop(); // Close the circular progress indicator
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return AddressDetailsScreen(
                                      devotee: newDevotee);
                                }),
                              );
                            } else {
                              Navigator.of(context)
                                  .pop(); // Close the circular progress indicator
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('devotee update issue')));
                            }
                          } catch (e) {
                            Navigator.of(context)
                                .pop(); // Close the circular progress indicator
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
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
