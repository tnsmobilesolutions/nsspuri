import 'dart:convert';

import 'package:sammilani_delegate/API/dio_fuction.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';

class PostDevoteeAPI extends DioFuctionAPI {
addDevotee (DevoteeModel devotee) async {
    // Dio dio = Dio();
    var encodedata = jsonEncode(devotee.toMap());
    try {
   await postAPI("devotee", encodedata);
      print("devotee Encooded Data - $encodedata");
    } catch (e) {
      print("Post Error....");
      print(e);
    }
  }



}