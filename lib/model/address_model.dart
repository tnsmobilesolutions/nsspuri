import 'dart:convert';

class AddressModel {
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? country;
  int? pincode;
  AddressModel({
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.country,
    this.pincode,
  });

  AddressModel copyWith({
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? state,
    String? country,
    int? pincode,
  }) {
    return AddressModel(
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      pincode: pincode ?? this.pincode,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(addressLine1 != null){
      result.addAll({'addressLine1': addressLine1});
    }
    if(addressLine2 != null){
      result.addAll({'addressLine2': addressLine2});
    }
    if(city != null){
      result.addAll({'city': city});
    }
    if(state != null){
      result.addAll({'state': state});
    }
    if(country != null){
      result.addAll({'country': country});
    }
    if(pincode != null){
      result.addAll({'pincode': pincode});
    }
  
    return result;
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      addressLine1: map['addressLine1'],
      addressLine2: map['addressLine2'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
      pincode: map['pincode']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) => AddressModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddressModel(addressLine1: $addressLine1, addressLine2: $addressLine2, city: $city, state: $state, country: $country, pincode: $pincode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AddressModel &&
      other.addressLine1 == addressLine1 &&
      other.addressLine2 == addressLine2 &&
      other.city == city &&
      other.state == state &&
      other.country == country &&
      other.pincode == pincode;
  }

  @override
  int get hashCode {
    return addressLine1.hashCode ^
      addressLine2.hashCode ^
      city.hashCode ^
      state.hashCode ^
      country.hashCode ^
      pincode.hashCode;
  }
}
