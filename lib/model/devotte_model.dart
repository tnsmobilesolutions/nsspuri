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
  String? role;
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
    String? role,
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
      role: role ?? this.role,
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
    final result = <String, dynamic>{};
  
    if(devoteeId != null){
      result.addAll({'devoteeId': devoteeId});
    }
    if(devoteeCode != null){
      result.addAll({'devoteeCode': devoteeCode});
    }
    if(name != null){
      result.addAll({'name': name});
    }
    if(emailId != null){
      result.addAll({'emailId': emailId});
    }
    if(mobileNumber != null){
      result.addAll({'mobileNumber': mobileNumber});
    }
    if(bloodGroup != null){
      result.addAll({'bloodGroup': bloodGroup});
    }
    if(profilePhotoUrl != null){
      result.addAll({'profilePhotoUrl': profilePhotoUrl});
    }
    if(gender != null){
      result.addAll({'gender': gender});
    }
    if(sangha != null){
      result.addAll({'sangha': sangha});
    }
    if(role != null){
      result.addAll({'role': role});
    }
    if(uid != null){
      result.addAll({'uid': uid});
    }
    if(isGuest != null){
      result.addAll({'isGuest': isGuest});
    }
    if(isOrganizer != null){
      result.addAll({'isOrganizer': isOrganizer});
    }
    if(isSpeciallyAbled != null){
      result.addAll({'isSpeciallyAbled': isSpeciallyAbled});
    }
    if(dob != null){
      result.addAll({'dob': dob});
    }
    if(isKYDVerified != null){
      result.addAll({'isKYDVerified': isKYDVerified});
    }
    if(isAllowedToScanPrasad != null){
      result.addAll({'isAllowedToScanPrasad': isAllowedToScanPrasad});
    }
    if(isApproved != null){
      result.addAll({'isApproved': isApproved});
    }
    if(isAdmin != null){
      result.addAll({'isAdmin': isAdmin});
    }
    if(isGruhasanaApproved != null){
      result.addAll({'isGruhasanaApproved': isGruhasanaApproved});
    }
    if(createdOn != null){
      result.addAll({'createdOn': createdOn});
    }
    if(updatedOn != null){
      result.addAll({'updatedOn': updatedOn});
    }
    if(status != null){
      result.addAll({'status': status});
    }
    if(createdById != null){
      result.addAll({'createdById': createdById});
    }
    if(hasParichayaPatra != null){
      result.addAll({'hasParichayaPatra': hasParichayaPatra});
    }
    if(address != null){
      result.addAll({'address': address!.toMap()});
    }
  
    return result;
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
      address: map['address'] != null ? AddressModel.fromMap(map['address']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DevoteeModel.fromJson(String source) =>
      DevoteeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DevoteeModel(devoteeId: $devoteeId, devoteeCode: $devoteeCode, name: $name, emailId: $emailId, mobileNumber: $mobileNumber, bloodGroup: $bloodGroup, profilePhotoUrl: $profilePhotoUrl, gender: $gender, sangha: $sangha, role: $role, uid: $uid, isGuest: $isGuest, isOrganizer: $isOrganizer, isSpeciallyAbled: $isSpeciallyAbled, dob: $dob, isKYDVerified: $isKYDVerified, isAllowedToScanPrasad: $isAllowedToScanPrasad, isApproved: $isApproved, isAdmin: $isAdmin, isGruhasanaApproved: $isGruhasanaApproved, createdOn: $createdOn, updatedOn: $updatedOn, status: $status, createdById: $createdById, hasParichayaPatra: $hasParichayaPatra, address: $address)';
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
