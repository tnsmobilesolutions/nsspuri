// ignore_for_file: avoid_print, must_be_immutable
// ignore: depend_on_referenced_packages
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
import 'package:sammilani_delegate/API/post_devotee.dart';
import 'package:sammilani_delegate/API/put_devotee.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sammilani_delegate/home_page/home_page.dart';
import 'package:sammilani_delegate/model/address_model.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/reusable_widgets/common_style.dart';
import 'package:sammilani_delegate/sangha_list/sangha_list.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';
import 'package:sammilani_delegate/utilities/custom_calender.dart';
import 'package:uuid/uuid.dart';

class EditDevoteeDetailsPage extends StatefulWidget {
  EditDevoteeDetailsPage(
      {Key? key,
      this.devoteeIndex,
      this.devotee,
      required this.title,
      required this.isRelatives})
      : super(key: key);

  DevoteeModel? devotee;
  int? devoteeIndex;
  String title;
  bool isRelatives;

  @override
  State<EditDevoteeDetailsPage> createState() => _EditDevoteeDetailsPageState();

  get currentUser => null;
}

class _EditDevoteeDetailsPageState extends State<EditDevoteeDetailsPage> {
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final remarkController = TextEditingController();

  String? bloodGroupController;
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

  final cityController = TextEditingController();
  final countryController = TextEditingController();
  String? devoteeId;
  TextEditingController dobController = TextEditingController();
  FocusNode focusNode = FocusNode();
  List gender = ["Male", "Female"];
  int genderController = 0;
  final mobileController = TextEditingController();
  final nameController = TextEditingController();
  bool? parichayaPatraValue = false;
  final postalCodeController = TextEditingController();
  XFile? previewImage;
  String? profileImage;
  String? profileURL;
  final sanghaController = TextEditingController();
  // bool _validate = false;
  // bool _validate1 = false;
  List<String>? sanghaSuggestions = [];
  String day = "", month = "", year = "";
  String? select;
  DateTime selectedDate = DateTime.now();
  final stateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.devotee != null) {
      if (widget.devotee?.dob != null) {
        List<String> dateParts = widget.devotee!.dob!.split('-');

        if (dateParts.length >= 3) {
          setState(() {
            day = int.tryParse(dateParts[2])?.toString() ?? '';
            month = int.tryParse(dateParts[1])?.toString() ?? '';
            year = int.tryParse(dateParts[0])?.toString() ?? '';
          });
        } else {
          print('Invalid date format: ${widget.devotee?.dob}');
        }
      }
      nameController.text = widget.devotee?.name ?? "";
      genderController = widget.devotee?.gender == "Male" ? 0 : 1;
      mobileController.text = widget.devotee?.mobileNumber ?? "";
      sanghaController.text = widget.devotee?.sangha ?? "";
      dobController.text = widget.devotee?.dob != ""
          ? formatDate(widget.devotee?.dob ?? "")
          : "";
      bloodGroupController = widget.devotee?.bloodGroup ?? bloodGroupController;
      profileURL = widget.devotee?.profilePhotoUrl ?? "";
      addressLine1Controller.text = widget.devotee?.address?.addressLine1 ?? "";
      addressLine2Controller.text = widget.devotee?.address?.addressLine2 ?? "";
      cityController.text = widget.devotee?.address?.city ?? "";
      stateController.text = widget.devotee?.address?.state ?? "Odisha";
      postalCodeController.text = widget.devotee?.address?.postalCode != null
          ? "${widget.devotee?.address?.postalCode}"
          : "";
      countryController.text = widget.devotee?.address?.country ?? "India";
      parichayaPatraValue = widget.devotee?.hasParichayaPatra ?? false;
      remarkController.text = widget.devotee?.remarks ?? "";
    }
    stateController.text = "Odisha";
    countryController.text = "India";
  }

  get districtList => null;

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

  String formatDate(String inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);

    List<String> monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    int day = dateTime.day;
    String month = monthNames[dateTime.month - 1];
    int year = dateTime.year;

    String formattedDate = '$day-$month-$year';

    return formattedDate;
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
                day: day,
                month: month,
                year: year,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        );
      },
    );

    if (selectedDate != null) {
      print("selected date: $selectedDate");
      dobController.text = selectedDate;
      List<String> selectedDateParts = selectedDate.split('-');
      print("selected date parts: $selectedDateParts");
      setState(() {
        day = selectedDateParts[0];
        month = selectedDateParts[1];
        year = selectedDateParts[2];
      });
    }
  }

  String _formatDOB(String dob) {
    if (dob.isEmpty) {
      return '';
    }
    try {
      DateTime dateTime = DateFormat('d-MMM-yyyy', 'en_US').parse(dob);
      String formattedDate = DateFormat('y-MM-dd').format(dateTime);
      return formattedDate;
    } catch (e) {
      print("Error parsing date: $e");
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ScaffoldBackgroundColor,
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => const DelegateCard(),
        //       ),
        //     );
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back,
        //     color: Colors.deepOrange,
        //   ),
        // ),
        backgroundColor: AppBarColor,
        title: widget.title == 'edit'
            ? const Text('Edit Delegate')
            : const Text('Add Member'),
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
                  backgroundImage: (previewImage != null &&
                          previewImage!.path.isNotEmpty)
                      ? Image.file(
                          File('${previewImage?.path}'),
                          fit: BoxFit.cover,
                        ).image
                      : (profileURL != null && profileURL!.isNotEmpty)
                          ? Image.network(profileURL.toString()).image
                          : const AssetImage(
                              'assets/images/profile.jpeg'), // Set your default image asset path here
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
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                onSaved: (newValue) => nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.always,
                decoration: CommonStyle.textFieldStyle(
                    labelTextStr: "Name", hintTextStr: "Enter Name"),
              ),
              const SizedBox(
                height: 12,
              ),
              const SizedBox(height: 10),
              IntlPhoneField(
                dropdownIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.deepOrange,
                ),
                focusNode: focusNode,
                // validator: (value) {
                //   if (widget.isRelatives == true) {
                //     // If isRelatives is true, the mobile number is optional
                //     return null;
                //   } else {
                //     // If isRelatives is false, perform validation for the mobile number
                //     if ((value?.number ?? "").isEmpty) {
                //       return "Mobile Number is Required";
                //     } else {
                //       return null;
                //     }
                //   }
                // },
                autovalidateMode: widget.isRelatives
                    ? AutovalidateMode.disabled
                    : AutovalidateMode.always,
                validator: (phone) {
                  if (!widget.isRelatives && (phone?.number ?? "").isEmpty) {
                    return "Mobile Number is Required";
                  } else {
                    return null;
                  }
                },
                controller: mobileController,
                invalidNumberMessage: "Please enter a valid Mobile Number",
                keyboardType: TextInputType.phone,
                pickerDialogStyle: PickerDialogStyle(
                  searchFieldCursorColor: Colors.deepOrange,
                  searchFieldInputDecoration: InputDecoration(
                    label: const Text('Search Country'),
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepOrange),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black.withOpacity(0.5),
                      ),
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
                // Set autovalidateMode to always validate when interacting with the field
                //autovalidateMode: AutovalidateMode.always,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: <Widget>[
                    const Text(
                      'Gender',
                    ),
                    Expanded(
                      flex: 1,
                      child: RadioListTile(
                        value: 0,
                        groupValue: genderController,
                        title: const Text(
                          "Bhai",
                        ),
                        onChanged: (newValue) =>
                            setState(() => genderController = newValue ?? 0),
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

                        title: const Text(
                          "Maa",
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
              ),
              const SizedBox(
                height: 20,
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
                            Icons.calendar_month_rounded,
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
              TypeAheadFormField<String>(
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
                    const Text(
                      'Has Parichaya Patra ?',
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
                height: 20,
              ),
              TextFormField(
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
                keyboardType: TextInputType.phone,
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
              TextFormField(
                controller: remarkController,
                textCapitalization: TextCapitalization.words,
                onSaved: (newValue) => remarkController,
                validator: (value) {
                  return null;
                },
                autovalidateMode: AutovalidateMode.always,
                maxLines: 4,
                decoration: CommonStyle.textFieldStyle(
                    labelTextStr: "Remarks", hintTextStr: "Enter Remark"),
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
                          : widget.devotee?.profilePhotoUrl;

                      //String devoteeDOB = _formatDOB(dobController.text);
                      // print("devoteeee -- ${widget.devotee}");
                      DevoteeModel updateDevotee = DevoteeModel(
                          devoteeId: widget.title == "edit"
                              ? widget.devotee?.devoteeId
                              : const Uuid().v1(),
                          createdById: widget.title == "edit"
                              ? widget.devotee?.createdById
                              : const Uuid().v1(),
                          emailId: widget.devotee?.emailId,
                          bloodGroup: bloodGroupController,
                          name: nameController.text,
                          devoteeCode: widget.title == "edit"
                              ? widget.devotee?.devoteeCode
                              : 0,
                          isAdmin: widget.devotee?.isAdmin ?? false,
                          isAllowedToScanPrasad:
                              widget.devotee?.isAllowedToScanPrasad ?? false,
                          role: widget.devotee?.role,
                          gender: gender[genderController],
                          profilePhotoUrl: profileURL,
                          sangha: sanghaController.text,
                          dob: _formatDOB(dobController.text),
                          mobileNumber: mobileController.text,
                          createdOn: widget.devotee?.createdOn,
                          status: widget.devotee?.status ?? "dataSubmitted",
                          uid: widget.devotee?.uid ?? "",
                          updatedOn: DateTime.now().toString(),
                          hasParichayaPatra: parichayaPatraValue,
                          remarks: remarkController.text,
                          isSpeciallyAbled:
                              widget.devotee?.isSpeciallyAbled ?? false,
                          address: AddressModel(
                              addressLine2: addressLine2Controller.text,
                              addressLine1: addressLine1Controller.text,
                              country: countryController.text,
                              postalCode: postalCodeController.text == ""
                                  ? null
                                  : int.tryParse(postalCodeController.text),
                              city: cityController.text,
                              state: stateController.text));

                      Map<String, dynamic> response;
                      if (widget.title == "edit") {
                        response = await PutDevoteeAPI().updateDevotee(
                            updateDevotee, widget.devotee?.devoteeId ?? "");
                      } else {
                        response = await PostDevoteeAPI()
                            .addRelativeDevotee(updateDevotee);
                      }

                      if (response["statusCode"] == 200) {
                        if (context.mounted) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                        }
                        if (context.mounted) {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HomePage(index: widget.devoteeIndex),
                              ));
                        }
                      } else {
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('devotee update issue')));
                        }
                      }
                    } catch (e) {
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }

                      if (context.mounted) {
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(90)))),
                  child: Text(
                    widget.title == 'edit' ? "Update" : "Create",
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
