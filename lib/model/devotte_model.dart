// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:sammilani_delegate/model/address_model.dart';

class DevoteeModel {
  String? devoteeId;
  int? devoteeCode;
  String? name;
  String? emailId;
  String? mobileNumber;
  String? bloodGroup;
  String? profilePhotoUrl;
  String? gender;
  String? sangha;
  String? uid;
  bool? isGuest;
  bool? isOrganizer;
  bool? isSpeciallyAbled;
  String? dob;
  bool? isKYDVerified;
  bool? isAllowedToScanPrasad;
  bool? isApproved;
  bool? isAdmin;
  bool? isGruhasanaApproved;
  String? createdOn;
  String? updatedOn;
  String? status;
  String? createdById;
  bool?  hasParichayaPatra;

  AddressModel? address;
  DevoteeModel({
    this.devoteeId,
    this.devoteeCode,
    this.name,
    this.emailId,
    this.mobileNumber,
    this.bloodGroup,
    this.profilePhotoUrl,
    this.gender,
    this.sangha,
    this.uid,
    this.isGuest,
    this.isOrganizer,
    this.isSpeciallyAbled,
    this.dob,
    this.isKYDVerified,
    this.isAllowedToScanPrasad,
    this.isApproved,
    this.isAdmin,
    this.isGruhasanaApproved,
    this.createdOn,
    this.updatedOn,
    this.status,
    this.createdById,
    this.hasParichayaPatra,
    this.address,
  });

  DevoteeModel copyWith({
    String? devoteeId,
    int? devoteeCode,
    String? name,
    String? emailId,
    String? mobileNumber,
    String? bloodGroup,
    String? profilePhotoUrl,
    String? gender,
    String? sangha,
    String? uid,
    bool? isGuest,
    bool? isOrganizer,
    bool? isSpeciallyAbled,
    String? dob,
    bool? isKYDVerified,
    bool? isAllowedToScanPrasad,
    bool? isApproved,
    bool? isAdmin,
    bool? isGruhasanaApproved,
    String? createdOn,
    String? updatedOn,
    String? status,
    String? createdById,
    bool? hasParichayaPatra,
    AddressModel? address,
  }) {
    return DevoteeModel(
      devoteeId: devoteeId ?? this.devoteeId,
      devoteeCode: devoteeCode ?? this.devoteeCode,
      name: name ?? this.name,
      emailId: emailId ?? this.emailId,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      gender: gender ?? this.gender,
      sangha: sangha ?? this.sangha,
      uid: uid ?? this.uid,
      isGuest: isGuest ?? this.isGuest,
      isOrganizer: isOrganizer ?? this.isOrganizer,
      isSpeciallyAbled: isSpeciallyAbled ?? this.isSpeciallyAbled,
      dob: dob ?? this.dob,
      isKYDVerified: isKYDVerified ?? this.isKYDVerified,
      isAllowedToScanPrasad: isAllowedToScanPrasad ?? this.isAllowedToScanPrasad,
      isApproved: isApproved ?? this.isApproved,
      isAdmin: isAdmin ?? this.isAdmin,
      isGruhasanaApproved: isGruhasanaApproved ?? this.isGruhasanaApproved,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
      status: status ?? this.status,
      createdById: createdById ?? this.createdById,
      hasParichayaPatra: hasParichayaPatra ?? this.hasParichayaPatra,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'devoteeId': devoteeId,
      'devoteeCode': devoteeCode,
      'name': name,
      'emailId': emailId,
      'mobileNumber': mobileNumber,
      'bloodGroup': bloodGroup,
      'profilePhotoUrl': profilePhotoUrl,
      'gender': gender,
      'sangha': sangha,
      'uid': uid,
      'isGuest': isGuest,
      'isOrganizer': isOrganizer,
      'isSpeciallyAbled': isSpeciallyAbled,
      'dob': dob,
      'isKYDVerified': isKYDVerified,
      'isAllowedToScanPrasad': isAllowedToScanPrasad,
      'isApproved': isApproved,
      'isAdmin': isAdmin,
      'isGruhasanaApproved': isGruhasanaApproved,
      'createdOn': createdOn,
      'updatedOn': updatedOn,
      'status': status,
      'createdById': createdById,
      'hasParichayaPatra': hasParichayaPatra,
      'address': address?.toMap(),
    };
  }

  factory DevoteeModel.fromMap(Map<String, dynamic> map) {
    return DevoteeModel(
      devoteeId: map['devoteeId'] != null ? map['devoteeId'] as String : null,
      devoteeCode: map['devoteeCode'] != null ? map['devoteeCode'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      emailId: map['emailId'] != null ? map['emailId'] as String : null,
      mobileNumber: map['mobileNumber'] != null ? map['mobileNumber'] as String : null,
      bloodGroup: map['bloodGroup'] != null ? map['bloodGroup'] as String : null,
      profilePhotoUrl: map['profilePhotoUrl'] != null ? map['profilePhotoUrl'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      sangha: map['sangha'] != null ? map['sangha'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      isGuest: map['isGuest'] != null ? map['isGuest'] as bool : null,
      isOrganizer: map['isOrganizer'] != null ? map['isOrganizer'] as bool : null,
      isSpeciallyAbled: map['isSpeciallyAbled'] != null ? map['isSpeciallyAbled'] as bool : null,
      dob: map['dob'] != null ? map['dob'] as String : null,
      isKYDVerified: map['isKYDVerified'] != null ? map['isKYDVerified'] as bool : null,
      isAllowedToScanPrasad: map['isAllowedToScanPrasad'] != null ? map['isAllowedToScanPrasad'] as bool : null,
      isApproved: map['isApproved'] != null ? map['isApproved'] as bool : null,
      isAdmin: map['isAdmin'] != null ? map['isAdmin'] as bool : null,
      isGruhasanaApproved: map['isGruhasanaApproved'] != null ? map['isGruhasanaApproved'] as bool : null,
      createdOn: map['createdOn'] != null ? map['createdOn'] as String : null,
      updatedOn: map['updatedOn'] != null ? map['updatedOn'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      createdById: map['createdById'] != null ? map['createdById'] as String : null,
      hasParichayaPatra: map['hasParichayaPatra'] != null ? map['hasParichayaPatra'] as bool : null,
      address: map['address'] != null ? AddressModel.fromMap(map['address'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DevoteeModel.fromJson(String source) => DevoteeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DevoteeModel(devoteeId: $devoteeId, devoteeCode: $devoteeCode, name: $name, emailId: $emailId, mobileNumber: $mobileNumber, bloodGroup: $bloodGroup, profilePhotoUrl: $profilePhotoUrl, gender: $gender, sangha: $sangha, uid: $uid, isGuest: $isGuest, isOrganizer: $isOrganizer, isSpeciallyAbled: $isSpeciallyAbled, dob: $dob, isKYDVerified: $isKYDVerified, isAllowedToScanPrasad: $isAllowedToScanPrasad, isApproved: $isApproved, isAdmin: $isAdmin, isGruhasanaApproved: $isGruhasanaApproved, createdOn: $createdOn, updatedOn: $updatedOn, status: $status, createdById: $createdById, hasParichayaPatra: $hasParichayaPatra, address: $address)';
  }

  @override
  bool operator ==(covariant DevoteeModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.devoteeId == devoteeId &&
      other.devoteeCode == devoteeCode &&
      other.name == name &&
      other.emailId == emailId &&
      other.mobileNumber == mobileNumber &&
      other.bloodGroup == bloodGroup &&
      other.profilePhotoUrl == profilePhotoUrl &&
      other.gender == gender &&
      other.sangha == sangha &&
      other.uid == uid &&
      other.isGuest == isGuest &&
      other.isOrganizer == isOrganizer &&
      other.isSpeciallyAbled == isSpeciallyAbled &&
      other.dob == dob &&
      other.isKYDVerified == isKYDVerified &&
      other.isAllowedToScanPrasad == isAllowedToScanPrasad &&
      other.isApproved == isApproved &&
      other.isAdmin == isAdmin &&
      other.isGruhasanaApproved == isGruhasanaApproved &&
      other.createdOn == createdOn &&
      other.updatedOn == updatedOn &&
      other.status == status &&
      other.createdById == createdById &&
      other.hasParichayaPatra == hasParichayaPatra &&
      other.address == address;
  }

  @override
  int get hashCode {
    return devoteeId.hashCode ^
      devoteeCode.hashCode ^
      name.hashCode ^
      emailId.hashCode ^
      mobileNumber.hashCode ^
      bloodGroup.hashCode ^
      profilePhotoUrl.hashCode ^
      gender.hashCode ^
      sangha.hashCode ^
      uid.hashCode ^
      isGuest.hashCode ^
      isOrganizer.hashCode ^
      isSpeciallyAbled.hashCode ^
      dob.hashCode ^
      isKYDVerified.hashCode ^
      isAllowedToScanPrasad.hashCode ^
      isApproved.hashCode ^
      isAdmin.hashCode ^
      isGruhasanaApproved.hashCode ^
      createdOn.hashCode ^
      updatedOn.hashCode ^
      status.hashCode ^
      createdById.hashCode ^
      hasParichayaPatra.hashCode ^
      address.hashCode;
  }
}
