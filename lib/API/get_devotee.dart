import 'package:sammilani_delegate/API/dio_fuction.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';

class GetDevoteeAPI extends DioFuctionAPI {
  Future<DevoteeModel> loginDevotee(String uid) async {
    final response = await getAPI("login/$uid");
    print(response);
    DevoteeModel devotee =
        DevoteeModel.fromMap(response["data"]["singleDevotee"]);
    return devotee;
  }

  Future<DevoteeModel> singleDevoteebyId(String id) async {
    final response = await getAPI("devotee/$id");
    print(response);
    DevoteeModel devotee =
        DevoteeModel.fromMap(response["data"]["singleDevotee"]);
    return devotee;
  }
}
