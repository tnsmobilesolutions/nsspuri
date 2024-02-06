import 'dart:convert';

import 'package:flutter/foundation.dart';

class OfflinePrasad {
  List<int>? devoteeCodes;
  String? date;
  String? time;
  OfflinePrasad({
    this.devoteeCodes,
    this.date,
    this.time,
  });

  OfflinePrasad copyWith({
    List<int>? devoteeCodes,
    String? date,
    String? time,
  }) {
    return OfflinePrasad(
      devoteeCodes: devoteeCodes ?? this.devoteeCodes,
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'devoteeCodes': devoteeCodes,
      'date': date,
      'time': time,
    };
  }

  factory OfflinePrasad.fromMap(Map<String, dynamic> map) {
    return OfflinePrasad(
      devoteeCodes: List<int>.from(map['devoteeCodes']),
      date: map['date'],
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OfflinePrasad.fromJson(String source) =>
      OfflinePrasad.fromMap(json.decode(source));

  @override
  String toString() =>
      'OfflinePrasad(devoteeCodes: $devoteeCodes, date: $date, time: $time)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OfflinePrasad &&
        listEquals(other.devoteeCodes, devoteeCodes) &&
        other.date == date &&
        other.time == time;
  }

  @override
  int get hashCode => devoteeCodes.hashCode ^ date.hashCode ^ time.hashCode;
}
