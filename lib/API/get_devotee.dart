import 'package:sammilani_delegate/API/dio_fuction.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';

class GetDevoteeAPI extends DioFuctionAPI {
  Future<Map<String, dynamic>?> loginDevotee(String uid) async {
    try {
      final response = await getAPI("login/$uid");
      print(response);
      DevoteeModel devotee =
          DevoteeModel.fromMap(response["data"]["singleDevotee"]);
      return {"statusCode": 200, "data": devotee};
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": DevoteeModel.fromMap(null)};
    }
  }

  Future<Map<String, dynamic>?> singleDevoteebyId(String id) async {
    try {
      final response = await getAPI("devotee/$id");
      print(response);
      DevoteeModel devotee =
          DevoteeModel.fromMap(response["data"]["singleDevotee"]);
      return {"statusCode": 200, "data": devotee};
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": null};
    }
  }
}
