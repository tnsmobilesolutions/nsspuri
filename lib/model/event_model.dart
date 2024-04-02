import 'dart:convert';

class EventModel {
  String? eventAntendeeId;
  String? eventId;
  String? eventName;
  String? devoteeId;
  int? devoteeCode;
  String? inDate;
  String? outDate;
  String? remark;
  String? createdAt;
  String? updatedAt;
  bool? eventAttendance;
  EventModel({
    this.eventAntendeeId,
    this.eventId,
    this.eventName,
    this.devoteeId,
    this.devoteeCode,
    this.inDate,
    this.outDate,
    this.remark,
    this.createdAt,
    this.updatedAt,
    this.eventAttendance,
  });

  EventModel copyWith({
    String? eventAntendeeId,
    String? eventId,
    String? eventName,
    String? devoteeId,
    int? devoteeCode,
    String? inDate,
    String? outDate,
    String? remark,
    String? createdAt,
    String? updatedAt,
    bool? eventAttendance,
  }) {
    return EventModel(
      eventAntendeeId: eventAntendeeId ?? this.eventAntendeeId,
      eventId: eventId ?? this.eventId,
      eventName: eventName ?? this.eventName,
      devoteeId: devoteeId ?? this.devoteeId,
      devoteeCode: devoteeCode ?? this.devoteeCode,
      inDate: inDate ?? this.inDate,
      outDate: outDate ?? this.outDate,
      remark: remark ?? this.remark,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      eventAttendance: eventAttendance ?? this.eventAttendance,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(eventAntendeeId != null){
      result.addAll({'eventAntendeeId': eventAntendeeId});
    }
    if(eventId != null){
      result.addAll({'eventId': eventId});
    }
    if(eventName != null){
      result.addAll({'eventName': eventName});
    }
    if(devoteeId != null){
      result.addAll({'devoteeId': devoteeId});
    }
    if(devoteeCode != null){
      result.addAll({'devoteeCode': devoteeCode});
    }
    if(inDate != null){
      result.addAll({'inDate': inDate});
    }
    if(outDate != null){
      result.addAll({'outDate': outDate});
    }
    if(remark != null){
      result.addAll({'remark': remark});
    }
    if(createdAt != null){
      result.addAll({'createdAt': createdAt});
    }
    if(updatedAt != null){
      result.addAll({'updatedAt': updatedAt});
    }
    if(eventAttendance != null){
      result.addAll({'eventAttendance': eventAttendance});
    }
  
    return result;
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      eventAntendeeId: map['eventAntendeeId'],
      eventId: map['eventId'],
      eventName: map['eventName'],
      devoteeId: map['devoteeId'],
      devoteeCode: map['devoteeCode']?.toInt(),
      inDate: map['inDate'],
      outDate: map['outDate'],
      remark: map['remark'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      eventAttendance: map['eventAttendance'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) => EventModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EventModel(eventAntendeeId: $eventAntendeeId, eventId: $eventId, eventName: $eventName, devoteeId: $devoteeId, devoteeCode: $devoteeCode, inDate: $inDate, outDate: $outDate, remark: $remark, createdAt: $createdAt, updatedAt: $updatedAt, eventAttendance: $eventAttendance)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is EventModel &&
      other.eventAntendeeId == eventAntendeeId &&
      other.eventId == eventId &&
      other.eventName == eventName &&
      other.devoteeId == devoteeId &&
      other.devoteeCode == devoteeCode &&
      other.inDate == inDate &&
      other.outDate == outDate &&
      other.remark == remark &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt &&
      other.eventAttendance == eventAttendance;
  }

  @override
  int get hashCode {
    return eventAntendeeId.hashCode ^
      eventId.hashCode ^
      eventName.hashCode ^
      devoteeId.hashCode ^
      devoteeCode.hashCode ^
      inDate.hashCode ^
      outDate.hashCode ^
      remark.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      eventAttendance.hashCode;
  }
}
