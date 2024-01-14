// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/widgets.dart';

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
  String? role;
  String? uid;
  bool? isGuest;
  String? remarks;
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
  bool? hasParichayaPatra;

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
    this.role,
    this.uid,
    this.isGuest,
    this.remarks,
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
    ValueGetter<String?>? devoteeId,
    ValueGetter<int?>? devoteeCode,
    ValueGetter<String?>? name,
    ValueGetter<String?>? emailId,
    ValueGetter<String?>? mobileNumber,
    ValueGetter<String?>? bloodGroup,
    ValueGetter<String?>? profilePhotoUrl,
    ValueGetter<String?>? gender,
    ValueGetter<String?>? sangha,
    ValueGetter<String?>? role,
    ValueGetter<String?>? uid,
    ValueGetter<bool?>? isGuest,
    ValueGetter<String?>? remarks,
    ValueGetter<bool?>? isOrganizer,
    ValueGetter<bool?>? isSpeciallyAbled,
    ValueGetter<String?>? dob,
    ValueGetter<bool?>? isKYDVerified,
    ValueGetter<bool?>? isAllowedToScanPrasad,
    ValueGetter<bool?>? isApproved,
    ValueGetter<bool?>? isAdmin,
    ValueGetter<bool?>? isGruhasanaApproved,
    ValueGetter<String?>? createdOn,
    ValueGetter<String?>? updatedOn,
    ValueGetter<String?>? status,
    ValueGetter<String?>? createdById,
    ValueGetter<bool?>? hasParichayaPatra,
    ValueGetter<AddressModel?>? address,
  }) {
    return DevoteeModel(
      devoteeId: devoteeId != null ? devoteeId() : this.devoteeId,
      devoteeCode: devoteeCode != null ? devoteeCode() : this.devoteeCode,
      name: name != null ? name() : this.name,
      emailId: emailId != null ? emailId() : this.emailId,
      mobileNumber: mobileNumber != null ? mobileNumber() : this.mobileNumber,
      bloodGroup: bloodGroup != null ? bloodGroup() : this.bloodGroup,
      profilePhotoUrl:
          profilePhotoUrl != null ? profilePhotoUrl() : this.profilePhotoUrl,
      gender: gender != null ? gender() : this.gender,
      sangha: sangha != null ? sangha() : this.sangha,
      role: role != null ? role() : this.role,
      uid: uid != null ? uid() : this.uid,
      isGuest: isGuest != null ? isGuest() : this.isGuest,
      remarks: remarks != null ? remarks() : this.remarks,
      isOrganizer: isOrganizer != null ? isOrganizer() : this.isOrganizer,
      isSpeciallyAbled:
          isSpeciallyAbled != null ? isSpeciallyAbled() : this.isSpeciallyAbled,
      dob: dob != null ? dob() : this.dob,
      isKYDVerified:
          isKYDVerified != null ? isKYDVerified() : this.isKYDVerified,
      isAllowedToScanPrasad: isAllowedToScanPrasad != null
          ? isAllowedToScanPrasad()
          : this.isAllowedToScanPrasad,
      isApproved: isApproved != null ? isApproved() : this.isApproved,
      isAdmin: isAdmin != null ? isAdmin() : this.isAdmin,
      isGruhasanaApproved: isGruhasanaApproved != null
          ? isGruhasanaApproved()
          : this.isGruhasanaApproved,
      createdOn: createdOn != null ? createdOn() : this.createdOn,
      updatedOn: updatedOn != null ? updatedOn() : this.updatedOn,
      status: status != null ? status() : this.status,
      createdById: createdById != null ? createdById() : this.createdById,
      hasParichayaPatra: hasParichayaPatra != null
          ? hasParichayaPatra()
          : this.hasParichayaPatra,
      address: address != null ? address() : this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'devoteeId': devoteeId,
      'devoteeCode': devoteeCode,
      'name': name,
      'emailId': emailId,
      'mobileNumber': mobileNumber,
      'bloodGroup': bloodGroup,
      'profilePhotoUrl': profilePhotoUrl,
      'gender': gender,
      'sangha': sangha,
      'role': role,
      'uid': uid,
      'isGuest': isGuest,
      'remarks': remarks,
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
      devoteeId: map['devoteeId'],
      devoteeCode: map['devoteeCode']?.toInt(),
      name: map['name'],
      emailId: map['emailId'],
      mobileNumber: map['mobileNumber'],
      bloodGroup: map['bloodGroup'],
      profilePhotoUrl: map['profilePhotoUrl'],
      gender: map['gender'],
      sangha: map['sangha'],
      role: map['role'],
      uid: map['uid'],
      isGuest: map['isGuest'],
      remarks: map['remarks'],
      isOrganizer: map['isOrganizer'],
      isSpeciallyAbled: map['isSpeciallyAbled'],
      dob: map['dob'],
      isKYDVerified: map['isKYDVerified'],
      isAllowedToScanPrasad: map['isAllowedToScanPrasad'],
      isApproved: map['isApproved'],
      isAdmin: map['isAdmin'],
      isGruhasanaApproved: map['isGruhasanaApproved'],
      createdOn: map['createdOn'],
      updatedOn: map['updatedOn'],
      status: map['status'],
      createdById: map['createdById'],
      hasParichayaPatra: map['hasParichayaPatra'],
      address:
          map['address'] != null ? AddressModel.fromMap(map['address']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DevoteeModel.fromJson(String source) =>
      DevoteeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DevoteeModel(devoteeId: $devoteeId, devoteeCode: $devoteeCode, name: $name, emailId: $emailId, mobileNumber: $mobileNumber, bloodGroup: $bloodGroup, profilePhotoUrl: $profilePhotoUrl, gender: $gender, sangha: $sangha, role: $role, uid: $uid, isGuest: $isGuest, remarks: $remarks, isOrganizer: $isOrganizer, isSpeciallyAbled: $isSpeciallyAbled, dob: $dob, isKYDVerified: $isKYDVerified, isAllowedToScanPrasad: $isAllowedToScanPrasad, isApproved: $isApproved, isAdmin: $isAdmin, isGruhasanaApproved: $isGruhasanaApproved, createdOn: $createdOn, updatedOn: $updatedOn, status: $status, createdById: $createdById, hasParichayaPatra: $hasParichayaPatra, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DevoteeModel &&
        other.devoteeId == devoteeId &&
        other.devoteeCode == devoteeCode &&
        other.name == name &&
        other.emailId == emailId &&
        other.mobileNumber == mobileNumber &&
        other.bloodGroup == bloodGroup &&
        other.profilePhotoUrl == profilePhotoUrl &&
        other.gender == gender &&
        other.sangha == sangha &&
        other.role == role &&
        other.uid == uid &&
        other.isGuest == isGuest &&
        other.remarks == remarks &&
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
        role.hashCode ^
        uid.hashCode ^
        isGuest.hashCode ^
        remarks.hashCode ^
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
