import 'dart:convert';

class DevoteeModel {
  String? devoteeName;
  String? mobileNumber;
  String? bloodGroup;
  String? profileImageURL;
  String? gender;
  String? profession;
  String? sanghaName;
  String? presentAddress;
  String? permanentAddress;
  DevoteeModel({
    this.devoteeName,
    this.mobileNumber,
    this.bloodGroup,
    this.profileImageURL,
    this.gender,
    this.profession,
    this.sanghaName,
    this.presentAddress,
    this.permanentAddress,
  });

  DevoteeModel copyWith({
    String? devoteeName,
    String? mobileNumber,
    String? bloodGroup,
    String? profileImageURL,
    String? gender,
    String? profession,
    String? sanghaName,
    String? presentAddress,
    String? permanentAddress,
  }) {
    return DevoteeModel(
      devoteeName: devoteeName ?? this.devoteeName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      profileImageURL: profileImageURL ?? this.profileImageURL,
      gender: gender ?? this.gender,
      profession: profession ?? this.profession,
      sanghaName: sanghaName ?? this.sanghaName,
      presentAddress: presentAddress ?? this.presentAddress,
      permanentAddress: permanentAddress ?? this.permanentAddress,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(devoteeName != null){
      result.addAll({'devoteeName': devoteeName});
    }
    if(mobileNumber != null){
      result.addAll({'mobileNumber': mobileNumber});
    }
    if(bloodGroup != null){
      result.addAll({'bloodGroup': bloodGroup});
    }
    if(profileImageURL != null){
      result.addAll({'profileImageURL': profileImageURL});
    }
    if(gender != null){
      result.addAll({'gender': gender});
    }
    if(profession != null){
      result.addAll({'profession': profession});
    }
    if(sanghaName != null){
      result.addAll({'sanghaName': sanghaName});
    }
    if(presentAddress != null){
      result.addAll({'presentAddress': presentAddress});
    }
    if(permanentAddress != null){
      result.addAll({'permanentAddress': permanentAddress});
    }
  
    return result;
  }

  factory DevoteeModel.fromMap(Map<String, dynamic> map) {
    return DevoteeModel(
      devoteeName: map['devoteeName'],
      mobileNumber: map['mobileNumber'],
      bloodGroup: map['bloodGroup'],
      profileImageURL: map['profileImageURL'],
      gender: map['gender'],
      profession: map['profession'],
      sanghaName: map['sanghaName'],
      presentAddress: map['presentAddress'],
      permanentAddress: map['permanentAddress'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DevoteeModel.fromJson(String source) => DevoteeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DevoteeModel(devoteeName: $devoteeName, mobileNumber: $mobileNumber, bloodGroup: $bloodGroup, profileImageURL: $profileImageURL, gender: $gender, profession: $profession, sanghaName: $sanghaName, presentAddress: $presentAddress, permanentAddress: $permanentAddress)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DevoteeModel &&
      other.devoteeName == devoteeName &&
      other.mobileNumber == mobileNumber &&
      other.bloodGroup == bloodGroup &&
      other.profileImageURL == profileImageURL &&
      other.gender == gender &&
      other.profession == profession &&
      other.sanghaName == sanghaName &&
      other.presentAddress == presentAddress &&
      other.permanentAddress == permanentAddress;
  }

  @override
  int get hashCode {
    return devoteeName.hashCode ^
      mobileNumber.hashCode ^
      bloodGroup.hashCode ^
      profileImageURL.hashCode ^
      gender.hashCode ^
      profession.hashCode ^
      sanghaName.hashCode ^
      presentAddress.hashCode ^
      permanentAddress.hashCode;
  }
}
