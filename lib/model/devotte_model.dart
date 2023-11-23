// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:sammilani_delegate/model/address_model.dart';

class DevoteeModel {
  String? devoteeId;
  String? name;
  String? emailId;
  String? mobileNumber;
  String? bloodGroup;
  String? profilePhotoUrl;
  String? gender;
  String? sangha;
  String? uid;
  String? dob;
  bool? isKYDVerified;
  bool? isApproved;
  bool? isAdmin;
  bool? isGruhasanaApproved;
  String? createdOn;
  String? updatedOn;
  String? status;
  String? createdById;

  AddressModel? address;
  DevoteeModel({
    this.devoteeId,
    this.name,
    this.emailId,
    this.mobileNumber,
    this.bloodGroup,
    this.profilePhotoUrl,
    this.gender,
    this.sangha,
    this.uid,
    this.dob,
    this.isKYDVerified,
    this.isApproved,
    this.isAdmin,
    this.isGruhasanaApproved,
    this.createdOn,
    this.updatedOn,
    this.status,
    this.createdById,
    this.address,
  });

  DevoteeModel copyWith({
    String? devoteeId,
    String? name,
    String? emailId,
    String? mobileNumber,
    String? bloodGroup,
    String? profilePhotoUrl,
    String? gender,
    String? sangha,
    String? uid,
    String? dob,
    bool? isKYDVerified,
    bool? isApproved,
    bool? isAdmin,
    bool? isGruhasanaApproved,
    String? createdOn,
    String? updatedOn,
    String? status,
    String? createdById,
    AddressModel? address,
  }) {
    return DevoteeModel(
      devoteeId: devoteeId ?? this.devoteeId,
      name: name ?? this.name,
      emailId: emailId ?? this.emailId,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      gender: gender ?? this.gender,
      sangha: sangha ?? this.sangha,
      uid: uid ?? this.uid,
      dob: dob ?? this.dob,
      isKYDVerified: isKYDVerified ?? this.isKYDVerified,
      isApproved: isApproved ?? this.isApproved,
      isAdmin: isAdmin ?? this.isAdmin,
      isGruhasanaApproved: isGruhasanaApproved ?? this.isGruhasanaApproved,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
      status: status ?? this.status,
      createdById: createdById ?? this.createdById,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'devoteeId': devoteeId,
      'name': name,
      'emailId': emailId,
      'mobileNumber': mobileNumber,
      'bloodGroup': bloodGroup,
      'profilePhotoUrl': profilePhotoUrl,
      'gender': gender,
      'sangha': sangha,
      'uid': uid,
      'dob': dob,
      'isKYDVerified': isKYDVerified,
      'isApproved': isApproved,
      'isAdmin': isAdmin,
      'isGruhasanaApproved': isGruhasanaApproved,
      'createdOn': createdOn,
      'updatedOn': updatedOn,
      'status': status,
      'createdById': createdById,
      'address': address?.toMap(),
    };
  }

  factory DevoteeModel.fromMap(Map<String, dynamic> map) {
    return DevoteeModel(
      devoteeId: map['devoteeId'] != null ? map['devoteeId'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      emailId: map['emailId'] != null ? map['emailId'] as String : null,
      mobileNumber:
          map['mobileNumber'] != null ? map['mobileNumber'] as String : null,
      bloodGroup:
          map['bloodGroup'] != null ? map['bloodGroup'] as String : null,
      profilePhotoUrl: map['profilePhotoUrl'] != null
          ? map['profilePhotoUrl'] as String
          : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      sangha: map['sangha'] != null ? map['sangha'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      dob: map['dob'] != null ? map['dob'] as String : null,
      isKYDVerified:
          map['isKYDVerified'] != null ? map['isKYDVerified'] as bool : null,
      isApproved: map['isApproved'] != null ? map['isApproved'] as bool : null,
      isAdmin: map['isAdmin'] != null ? map['isAdmin'] as bool : null,
      isGruhasanaApproved: map['isGruhasanaApproved'] != null
          ? map['isGruhasanaApproved'] as bool
          : null,
      createdOn: map['createdOn'] != null ? map['createdOn'] as String : null,
      updatedOn: map['updatedOn'] != null ? map['updatedOn'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      createdById:
          map['createdById'] != null ? map['createdById'] as String : null,
      address: map['address'] != null
          ? AddressModel.fromMap(map['address'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DevoteeModel.fromJson(String source) =>
      DevoteeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DevoteeModel(devoteeId: $devoteeId, name: $name, emailId: $emailId, mobileNumber: $mobileNumber, bloodGroup: $bloodGroup, profilePhotoUrl: $profilePhotoUrl, gender: $gender, sangha: $sangha, uid: $uid, dob: $dob, isKYDVerified: $isKYDVerified, isApproved: $isApproved, isAdmin: $isAdmin, isGruhasanaApproved: $isGruhasanaApproved, createdOn: $createdOn, updatedOn: $updatedOn, status: $status, createdById: $createdById, address: $address)';
  }

  @override
  bool operator ==(covariant DevoteeModel other) {
    if (identical(this, other)) return true;

    return other.devoteeId == devoteeId &&
        other.name == name &&
        other.emailId == emailId &&
        other.mobileNumber == mobileNumber &&
        other.bloodGroup == bloodGroup &&
        other.profilePhotoUrl == profilePhotoUrl &&
        other.gender == gender &&
        other.sangha == sangha &&
        other.uid == uid &&
        other.dob == dob &&
        other.isKYDVerified == isKYDVerified &&
        other.isApproved == isApproved &&
        other.isAdmin == isAdmin &&
        other.isGruhasanaApproved == isGruhasanaApproved &&
        other.createdOn == createdOn &&
        other.updatedOn == updatedOn &&
        other.status == status &&
        other.createdById == createdById &&
        other.address == address;
  }

  @override
  int get hashCode {
    return devoteeId.hashCode ^
        name.hashCode ^
        emailId.hashCode ^
        mobileNumber.hashCode ^
        bloodGroup.hashCode ^
        profilePhotoUrl.hashCode ^
        gender.hashCode ^
        sangha.hashCode ^
        uid.hashCode ^
        dob.hashCode ^
        isKYDVerified.hashCode ^
        isApproved.hashCode ^
        isAdmin.hashCode ^
        isGruhasanaApproved.hashCode ^
        createdOn.hashCode ^
        updatedOn.hashCode ^
        status.hashCode ^
        createdById.hashCode ^
        address.hashCode;
  }
}
