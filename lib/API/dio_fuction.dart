import 'package:dio/dio.dart';

String baseUrl = "https://apiqa.mymedstore.in/";

abstract class DioFuctionAPI {
  final dio = Dio();
  Response? response;

  //post
  Future<Map<String, dynamic>> postAPI(String url, final encodedData) async {
    try {
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      // String? jwttoken = prefs.getString('jwtToken');

      response = await dio.post(
        baseUrl + url,
        data: encodedData,
      );

      if (response?.statusCode == 200) {
        return {"status": response?.statusCode, "data": response?.data};
      } else {
        return {"status": response?.statusCode, "error": "Error in Post API"};
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print("error message : ${e.response!.data["message"]}");
          return {
            "status": 500,
            "error": [e.response!.data["message"], false]
          };
        } else {
          return {
            "status": 500,
            "error": [e.response!.data["message"], false]
          };
          // return ['Dio error: ${e.message}', false];
        }
      } else {
        return {
          "status": 500,
          "error": ['An error occurred: ${e.toString()}', false]
        };

       
      }
    }
  }
}
