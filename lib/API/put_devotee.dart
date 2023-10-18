import 'dart:convert';

import 'package:sammilani_delegate/API/dio_fuction.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';

class PutDevoteeAPI extends DioFuctionAPI {
  updateDevotee(DevoteeModel devotee, String devoteeId) async {
    // Dio dio = Dio();
    var encodedata = jsonEncode(devotee.toMap());
    try {
      await putAPI("devotee/$devoteeId", encodedata);
      print("devotee Encooded Data - $encodedata");
    } catch (e) {
      print("Post Error....");
      print(e);
    }
  }
}
