import 'package:dio/dio.dart';
import 'package:sammilani_delegate/model/sangha_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

String baseUrl = "https://api.nsspuri.org/";

abstract class DioFuctionAPI {
  final dio = Dio();
  //GET
  Future<Map<String, dynamic>> getAPI(String url) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? jwttoken = prefs.getString('jwtToken');

      if (jwttoken == null) {
        throw Exception('JWT token is null');
      }
      final response = await dio.get(
        baseUrl + url,
        options: Options(
          headers: {'Authorization': 'Bearer $jwttoken'},
        ),
      );
    

      if (response.statusCode == 200) {
        return {"statusCode": 200, "data": response.data};
      } else {
        return {"statusCode": 500, "error": "Get api error"};
      }
    } catch (e) {
      print(e);
      return {"statusCode": 500, "error": e};
    }
  }

  //GET
  Future<Map<String, dynamic>> loginAPI(String url) async {
    try {
      final response = await dio.get(baseUrl + url);
      if (response.statusCode == 200) {
        // Obtain shared preferences.
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwtToken', '${response.data["accesstoken"]}');
        return {"statusCode": 200, "data": response.data};
      } else {
        return {"statusCode": 500, "error": "Get api error"};
      }
    } catch (e) {
      print(e);
      return {"statusCode": 500, "error": e};
    }
  }

  //post
  Future<Map<String, dynamic>> signupAPI(String url, final encodedData) async {
    try {
      final response = await dio.post(
        baseUrl + url,
        data: encodedData,
      );

      if (response.statusCode == 200) {
        return {"statusCode": response.statusCode, "data": response.data};
      } else {
        return {"statusCode": 500, "error": "Error in Post API"};
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print("error message : ${e.response!.data["message"]}");
          return {
            "statusCode": 500,
            "error": [e.response!.data["message"], false]
          };
        } else {
          return {
            "statusCode": 500,
            "error": [e.response!.data["message"], false]
          };
          // return ['Dio error: ${e.message}', false];
        }
      } else {
        return {
          "statusCode": 500,
          "error": ['An error occurred: ${e.toString()}', false]
        };
      }
    }
  }

  //post
  Future<Map<String, dynamic>> postAPI(String url, final encodedData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? jwttoken = prefs.getString('jwtToken');

      if (jwttoken == null) {
        throw Exception('JWT token is null');
      }

      final response = await dio.post(
        baseUrl + url,
        data: encodedData,
        options: Options(headers: {'Authorization': 'Bearer $jwttoken'}),
      );

      if (response.statusCode == 200) {
        return {"statusCode": 200, "data": response.data};
      } else {
        return {"statusCode": 500, "error": "Error in Post API"};
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print("error message : ${e.response!.data["message"]}");
          return {
            "statusCode": 500,
            "error": [e.response!.data["message"], false]
          };
        } else {
          return {
            "statusCode": 500,
            "error": [e.response!.data["message"], false]
          };
          // return ['Dio error: ${e.message}', false];
        }
      } else {
        return {
          "statusCode": 500,
          "error": ['An error occurred: ${e.toString()}', false]
        };
      }
    }
  }

  //put
  Future<Map<String, dynamic>> putAPI(String url, final encodedData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? jwttoken = prefs.getString('jwtToken');

      if (jwttoken == null) {
        throw Exception('JWT token is null');
      }

      final response = await dio.put(
        baseUrl + url,
        data: encodedData,
        options: Options(headers: {'Authorization': 'Bearer $jwttoken'}),
      );

      if (response.statusCode == 200) {
        return {"statusCode": response.statusCode, "data": response.data};
      } else {
        return {
          "statusCode": response.statusCode,
          "error": "Error in Post API"
        };
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print("error message : ${e.response!.data["message"]}");
          return {
            "statusCode": 500,
            "error": [e.response!.data["message"], false]
          };
        } else {
          return {
            "statusCode": 500,
            "error": [e.response!.data["message"], false]
          };
          // return ['Dio error: ${e.message}', false];
        }
      } else {
        return {
          "statusCode": 500,
          "error": ['An error occurred: ${e.toString()}', false]
        };
      }
    }
  }
}
