import 'dart:convert';

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
      print("Post Error....");
      print(e);
      return {"statusCode": 500, "error": e};
    }
  }
}
