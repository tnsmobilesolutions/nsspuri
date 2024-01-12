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
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController sanghaController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String? bloodGroupController;
  DateTime selectedDate = DateTime.now();
  List<String>? sanghaSuggestions = [];
  bool? parichayaPatraValue = false;

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
  List gender = ["Male", "Female"];
  int genderValue = 0;

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

    if (pickedFile != null) {
      // Crop the picked image
      XFile? croppedFile = await cropImage(pickedFile);

      // Update the state with the cropped image
      setState(() {
        previewImage = croppedFile;
      });
    }
  }

  Future<XFile?> cropImage(XFile pickedFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
    );

    return croppedFile != null ? XFile(croppedFile.path) : null;
  }

  String _formatDOB(String dob) {
    String dateString = dob;
    DateTime dateTime = DateFormat('dd/MMM/yyyy', 'en').parse(dateString);
    String formattedDate = DateFormat('y-MM-dd').format(dateTime);
    return formattedDate;
  }

  void showPhotoOptions() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
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
                  leading: const Icon(
                    Icons.photo_album,
                    color: Colors.deepOrange,
                  ),
                  title: const Text(
                    "Select from Gallery",
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(ImageSource.camera);
                  },
                  leading: const Icon(
                    Icons.camera_alt,
                    color: Colors.deepOrange,
                  ),
                  title: const Text(
                    "Take a photo",
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
        FirebaseStorage.instance.ref('$name/${getImageName(image)}');
    await storage.putFile(File(image.path));
    return await storage.getDownloadURL();
  }

  // return image name
  String getImageName(XFile image) {
    return image.path.split("/").last;
  }

  // @override
  // void initState() {
  //   //dobController.text = "";
  //   super.initState();
  // }

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
                    CupertinoButton(
                      onPressed: () {
                        showPhotoOptions();
                      },
                      child: CircleAvatar(
                        backgroundImage: previewImage != null &&
                                previewImage!.path.isNotEmpty
                            ? Image.file(
                                File('${previewImage?.path}'),
                                fit: BoxFit.cover,
                              ).image
                            : const AssetImage('assets/images/profile.jpeg'),
                        radius: 60,
                        child: const Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.deepOrange,
                            size: 22.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      // style: Theme.of(context).textTheme.displaySmall,
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
                    IntlPhoneField(
                      dropdownIcon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.deepOrange,
                      ),
                      focusNode: focusNode,
                      validator: (value) {
                        if ((value?.number ?? "").isEmpty) {
                          return ("Please enter Mobile Number");
                        } else {
                          return null;
                        }
                      },
                      controller: mobileController,
                      invalidNumberMessage:
                          "Please enter a valid Mobile Number",
                      keyboardType: TextInputType.phone,
                      pickerDialogStyle: PickerDialogStyle(
                        searchFieldCursorColor: Colors.deepOrange,
                        searchFieldInputDecoration: InputDecoration(
                          label: const Text('Search Country'),
                          labelStyle: const TextStyle(
                              color: Colors.black), // Set label text color
                          hintStyle: TextStyle(
                              color: Colors.black
                                  .withOpacity(0.5)), // Set hint text color
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepOrange),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.5)),
                          ),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      decoration: CommonStyle.textFieldStyle(
                          labelTextStr: "Mobile Number",
                          hintTextStr: "Enter Mobile Number"),
                      initialCountryCode: 'IN',
                      onSaved: (value) {
                        mobileController.text = value.toString();
                      },
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Row(
                        children: <Widget>[
                          const Text(
                            'Gender',
                          ),
                          Expanded(
                            flex: 1,
                            child: RadioListTile(
                              value: 0,
                              groupValue: genderValue,
                              title: const Text(
                                "Bhai",
                              ),
                              onChanged: (newValue) =>
                                  setState(() => genderValue = newValue ?? 0),
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
                              groupValue: genderValue,

                              title: const Text(
                                "Maa",
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  genderValue = newValue ?? 0;
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
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: dobController,
                              decoration: CommonStyle.textFieldStyle(
                                labelTextStr: "Date Of Birth",
                                hintTextStr: "Enter Date Of Birth",
                                suffixIcon: const Icon(
                                  Icons.calendar_view_month_rounded,
                                  color: Colors.deepOrange,
                                ),
                              ),
                              readOnly: true,
                              onTap: () => _showCustomCalendarDialog(context),
                            ),
                          ),
                        ],
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
                            value: bloodGroupController,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.deepOrange,
                            ),
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
                        // style: Theme.of(context).textTheme.displaySmall,
                        controller: sanghaController,
                        decoration: CommonStyle.textFieldStyle(
                          labelTextStr: "Sangha Name",
                          hintTextStr: "Enter Sangha Name",
                          suffixIcon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.deepOrange,
                          ),
                        ),
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
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //SizedBox
                          const Text(
                            'Has Parichaya Patra?',
                          ), //Text
                          //SizedBox
                          /** Checkbox Widget **/
                          Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                              activeColor: Colors.deepOrange,
                              value: parichayaPatraValue,
                              onChanged: (bool? value) {
                                setState(() {
                                  parichayaPatraValue = value;
                                });
                              },
                            ),
                          ), //Checkbox
                        ], //<Widget>[]
                      ),
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
                            String? profileURL = previewImage != null
                                ? await uploadImageToFirebaseStorage(
                                    previewImage as XFile, nameController.text)
                                : null;
                            DevoteeModel newDevotee = DevoteeModel(
                              hasParichayaPatra: parichayaPatraValue,
                              createdOn: widget.devotee.createdOn,
                              devoteeId: widget.devotee.devoteeId,
                              devoteeCode: widget.devotee.devoteeCode,
                              isAdmin: widget.devotee.isAdmin,
                              isAllowedToScanPrasad:
                                  widget.devotee.isAllowedToScanPrasad,
                              updatedOn: widget.devotee.updatedOn,
                              uid: widget.devotee.uid,
                              emailId: widget.devotee.emailId,
                              createdById: widget.devotee.devoteeId,
                              bloodGroup: bloodGroupController,
                              name: nameController.text,
                              gender: gender[genderValue],
                              profilePhotoUrl: profileURL,
                              sangha: sanghaController.text,
                              dob: _formatDOB(dobController.text),
                              mobileNumber: mobileController.text,
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
