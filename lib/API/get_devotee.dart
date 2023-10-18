import 'package:sammilani_delegate/API/dio_fuction.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';

class GetDevoteeAPI extends DioFuctionAPI {
  Future<DevoteeModel> signInDevoteebyUID(String uid) async {
    final response = await getAPI("devotee/$uid");
    print(response);
    DevoteeModel devotee = DevoteeModel.fromMap(response["data"]);
    return devotee;
  }
}
