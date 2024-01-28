// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:sammilani_delegate/API/dio_fuction.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';

class PutDevoteeAPI extends DioFuctionAPI {
  Future<Map<String, dynamic>> updateDevotee(
      DevoteeModel devotee, String devoteeId) async {
    // Dio dio = Dio();
    var encodedata = jsonEncode(devotee.toMap());
    try {
      final response = await putAPI("devotee/$devoteeId", encodedata);
      print("devotee Encooded Data - $encodedata");
      return response;
    } catch (e) {
      print("Post Error....$e");
      return {"statusCode": 500, "error": e};
    }
  }

  Future<Map<String, dynamic>> updatePrasad(String devoteeCode) async {
    final date = DateFormat('y-MM-dd').format(DateTime.now());
    final time = DateFormat('HH:mm').format(DateTime.now());
    try {
      final data = {"date": date, "time": time};
      final encodedData = json.encode(data);
      final response = await putAPI("prasadUpdate/$devoteeCode", encodedData);
      return response;
    }
    // catch (e) {
    //   print("Post Error....$e");
    //   return {"statusCode": 500, "error": e};
    // }
    catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print("error : ${e.response!.data["error"]}");
          return {
            "statusCode": e.response?.statusCode,
            "error": [e.response!.data["error"], false],
          };
        } else {
          return {
            "statusCode": e.response?.statusCode,
            "error": e.response!.data["error"],
          };
          // return ['Dio error: ${e.message}', false];
        }
      } else {
        return {
          "statusCode": 500,
          "error": ['An error occurred: ${e.toString()}', false],
        };
      }
    }
  }
}
