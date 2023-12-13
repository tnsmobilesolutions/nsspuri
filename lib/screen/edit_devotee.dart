import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sammilani_delegate/API/get_devotee.dart';
import 'package:sammilani_delegate/API/post_devotee.dart';
import 'package:sammilani_delegate/API/put_devotee.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sammilani_delegate/home_page/home_page.dart';

import 'package:sammilani_delegate/model/address_model.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/reusable_widgets/common_style.dart';
import 'package:sammilani_delegate/sangha_list/sangha_list.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';
import 'package:uuid/uuid.dart';

// ignore: depend_on_referenced_packages

// ignore: must_be_immutable
class EditDevoteeDetailsPage extends StatefulWidget {
  EditDevoteeDetailsPage({Key? key, required this.devotee, required this.title})
      : super(key: key);
  DevoteeModel devotee;
  String title;
  get currentUser => null;

  @override
  State<EditDevoteeDetailsPage> createState() => _EditDevoteeDetailsPageState();
}

class _EditDevoteeDetailsPageState extends State<EditDevoteeDetailsPage> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final sanghaController = TextEditingController();
  TextEditingController dateInputController = TextEditingController();
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final postalCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? bloodGroupController;
  String? devoteeId;
  DateTime selectedDate = DateTime.now();
  // bool _validate = false;
  // bool _validate1 = false;
  List<String>? sanghaSuggestions = [];
  bool? parichayaPatraValue = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String formattedDate = DateFormat('y-MM-dd').format(selectedDate);
        dateInputController.text = formattedDate;
      });
    }
  }

  List gender = ["Bhai", "Maa"];
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
    "Don't know",
  ];

  get districtList => null;

// ...

  void selectImage(ImageSource source) async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 50);

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

  @override
  void initState() {
    super.initState();
    if (widget.title == "edit") {
      nameController.text = widget.devotee.name ?? "";
      genderController = widget.devotee.gender == "Bhai" ? 0 : 1;
      mobileController.text = widget.devotee.mobileNumber ?? "";
      sanghaController.text = widget.devotee.sangha ?? "";
      dateInputController.text = widget.devotee.dob ?? "";
      bloodGroupController = widget.devotee.bloodGroup ?? bloodGroupController;
      profileURL = widget.devotee.profilePhotoUrl ?? "";
      addressLine1Controller.text = widget.devotee.address?.addressLine1 ?? "";
      addressLine2Controller.text = widget.devotee.address?.addressLine2 ?? "";
      cityController.text = widget.devotee.address?.city ?? "";
      stateController.text = widget.devotee.address?.state ?? "Odisha";
      postalCodeController.text = widget.devotee.address?.postalCode != null
          ? "${widget.devotee.address?.postalCode}"
          : "";
      countryController.text = widget.devotee.address?.country ?? "India";
      parichayaPatraValue = widget.devotee.hasParichayaPatra ?? false;
    }
    stateController.text = "Odisha";
    countryController.text = "India";
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
        FirebaseStorage.instance.ref('$name/${getImageName(image)}');
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
      backgroundColor: ScaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppBarColor,
        title: widget.title == 'edit'
            ? const Text('Edit Delegate')
            : const Text('Add Relative Delegate'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CupertinoButton(
                onPressed: () {
                  showPhotoOptions();
                },
                child: CircleAvatar(
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
                      backgroundColor: CircleAvatarClor,
                      radius: 20.0,
                      child: Icon(
                        Icons.camera_alt,
                        size: 18.0,
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
                height: 12,
              ),
              const SizedBox(height: 10),
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
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Gender',
                          ),
                          Expanded(
                            flex: 1,
                            child: RadioListTile(
                              value: 0,
                              groupValue: genderController,
                              title: Text(
                                "Bhai",
                                style: Theme.of(context).textTheme.bodyMedium,
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
                                "Maa",
                                style: Theme.of(context).textTheme.bodyMedium,
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
                      hintTextStr: "Enter Date Of Birth"),
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
                  ),
                ),
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
                      ((sanghaSuggestions?.length ?? 0) > 0 &&
                          sanghaSuggestions
                                  ?.indexWhere((element) => element == value) ==
                              -1)) {
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
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //SizedBox
                    Text(
                      'Has Parichaya Patra?',
                      style: Theme.of(context).textTheme.bodyMedium,
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
                            this.parichayaPatraValue = value;
                          });
                        },
                      ),
                    ), //Checkbox
                  ], //<Widget>[]
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: Theme.of(context).textTheme.displaySmall,
                controller: addressLine1Controller,
                textCapitalization: TextCapitalization.words,
                onSaved: (newValue) => addressLine1Controller,
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Please enter address line 1';
                  // }
                  return null;
                },
                decoration: CommonStyle.textFieldStyle(
                    labelTextStr: "Address Line 1",
                    hintTextStr: "Enter Address Line 1"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: Theme.of(context).textTheme.displaySmall,
                controller: addressLine2Controller,
                textCapitalization: TextCapitalization.words,
                onSaved: (newValue) => addressLine2Controller,
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Please enter address line 2';
                  // }
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
                style: Theme.of(context).textTheme.displaySmall,
                controller: cityController,
                textCapitalization: TextCapitalization.words,
                onSaved: (newValue) => cityController,
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Please enter city name';
                  // }
                  return null;
                },
                decoration: CommonStyle.textFieldStyle(
                    labelTextStr: "City", hintTextStr: "Enter City Name"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: Theme.of(context).textTheme.displaySmall,
                controller: stateController,
                textCapitalization: TextCapitalization.words,
                onSaved: (newValue) => stateController,
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Please enter state name';
                  // }
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
                style: Theme.of(context).textTheme.displaySmall,
                textCapitalization: TextCapitalization.words,
                controller: countryController,
                onSaved: (newValue) => addressLine1Controller,
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Please enter country name';
                  // }
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
                onSaved: (newValue) {
                  postalCodeController.text = newValue.toString();
                  print("postalcode ==========================$newValue");
                },
                decoration: CommonStyle.textFieldStyle(
                    labelTextStr: "PIN Code", hintTextStr: "Enter PIN Code"),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(90)),
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
                    await Future.delayed(
                        const Duration(seconds: 1)); // Simulating a delay
                    try {
                      String? profileURL = previewImage != null
                          ? await uploadImageToFirebaseStorage(
                              previewImage as XFile, nameController.text)
                          : widget.devotee.profilePhotoUrl;

                      // print("devoteeee -- ${widget.devotee}");
                      DevoteeModel updateDevotee = DevoteeModel(
                          devoteeId: widget.title == "edit"
                              ? widget.devotee.devoteeId
                              : const Uuid().v1(),
                          createdById: widget.title == "edit"
                              ? widget.devotee.createdById
                              : const Uuid().v1(),
                          emailId: widget.devotee.emailId,
                          bloodGroup: bloodGroupController,
                          name: nameController.text,
                          devoteeCode: widget.title == "edit"
                              ? widget.devotee.devoteeCode
                              : 0,
                          isAdmin: widget.devotee.isAdmin ?? false,
                          isAllowedToScanPrasad:
                              widget.devotee.isAllowedToScanPrasad ?? false,
                          gender: gender[genderController],
                          profilePhotoUrl: profileURL,
                          sangha: sanghaController.text,
                          dob: dateInputController.text,
                          mobileNumber: mobileController.text,
                          createdOn: widget.devotee.createdOn,
                          status: widget.devotee.status ?? "dataSubmitted",
                          uid: widget.devotee.uid ?? "",
                          updatedOn: DateTime.now().toString(),
                          hasParichayaPatra: parichayaPatraValue,
                          isSpeciallyAbled:
                              widget.devotee.isSpeciallyAbled ?? false,
                          address: AddressModel(
                              addressLine2: addressLine2Controller.text,
                              addressLine1: addressLine1Controller.text,
                              country: countryController.text,
                              postalCode: postalCodeController.text == ""
                                  ? 0
                                  : int.tryParse(postalCodeController.text),
                              city: cityController.text,
                              state: stateController.text));

                      Map<String, dynamic> response;
                      if (widget.title == "edit") {
                        response = await PutDevoteeAPI().updateDevotee(
                            updateDevotee, widget.devotee.devoteeId.toString());
                      } else {
                        response = await PostDevoteeAPI()
                            .addRelativeDevotee(updateDevotee);
                      }

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
                              builder: (context) => const HomePage(),
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
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('devotee update issue')));
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(90)))),
                  child: Text(
                    widget.title == 'edit' ? "Update" : "Add your Relative",
                  ),

                  //Row
                ),

                //Row
              ),
            ]),
          ),
        ),
      )),
    );
  }
}
