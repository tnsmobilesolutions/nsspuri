// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:sammilani_delegate/API/dio_fuction.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';
import 'package:sammilani_delegate/model/sangha_model.dart';

class GetDevoteeAPI extends DioFuctionAPI {
  String baseUrl = "https://api.nsspuri.org/";
  Future<Map<String, dynamic>?> loginDevotee(String uid) async {
    try {
      final response = await loginAPI("login/$uid");
      print(response);
      DevoteeModel devotee =
          DevoteeModel.fromMap(response["data"]["singleDevotee"]);
      return {"statusCode": 200, "data": devotee};
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": null};
    }
  }

  Future<Map<String, dynamic>?> currentDevotee() async {
    try {
      final response = await getAPI("devotee/currentUser");
      print(response);
      DevoteeModel devotee =
          DevoteeModel.fromMap(response["data"]["singleDevotee"][0]);
      return {"statusCode": 200, "data": devotee};
    } catch (e) {
      print("i am in current$e");
      return {"statusCode": 500, "data": DevoteeModel()};
    }
  }

  Future<Map<String, dynamic>?> allDevotee() async {
    try {
      final response = await getAPI("devotee");
      print(response);
      return {"statusCode": 200, "data": response["data"]};
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": null};
    }
  }

  Future<Map<String, dynamic>?> searchDevotee(String devoteeName) async {
    try {
      final response = await getAPI("devotee/search?devoteeName=$devoteeName");
      print(response);
      return {"statusCode": 200, "data": response["data"]};
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": null};
    }
  }

  Future<Map<String, dynamic>?> devoteeWithRelatives() async {
    try {
      final response = await getAPI("devotee/relatives");

      return {"statusCode": 200, "data": response["data"]["singleDevotee"]};
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": null};
    }
  }

  Future<Map<String, dynamic>?> fetchAllSangha() async {
    try {
      final response = await getAPI("sangha");
      print('888888$response');
      return {"statusCode": 200, "data": response["data"]["allSangha"]};
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": null};
    }
  }

  Future<List<SanghaModel>?> getAllSangha() async {
    List<SanghaModel>? sanghas = [];
    // WRITE THE CODE HERE TO FETCH ALL SANGHA AND RETURN THE LIST
    Map<String, dynamic>? sanghaMap = await fetchAllSangha();
    SanghaModel sm;
    for (var sangha in sanghaMap?['data']) {
      sm = SanghaModel.fromMap(sangha);
      sanghas.add(sm);
    }

    return sanghas;
  }

  // Future<List<SanghaModel>?> getAllSangha() async {
  //   try {
  //     final response = await getAPI("sangha");
  //     print('888888$response');

  //     if (response["statusCode"] == 200) {
  //       List<SanghaModel> sanghas = [];

  //       for (var sangha in response["data"]["allSangha"]) {
  //         SanghaModel sm = SanghaModel.fromMap(sangha);
  //         sanghas.add(sm);
  //       }

  //       return sanghas;
  //     } else {
  //       return null; // Or handle the error in a way that suits your needs
  //     }
  //   } catch (e) {
  //     print(e);
  //     return null; // Or handle the error in a way that suits your needs
  //   }
  // }
}
