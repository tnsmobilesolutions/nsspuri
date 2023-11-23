import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sammilani_delegate/model/sangha_model.dart';

Future<List<SanghaModel>> fetchSanghaData(String value) async {
  final response = await http.get(Uri.parse('YOUR_API_ENDPOINT_HERE'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body)['data']['sanghaList'];
    return data.map((json) => SanghaModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load Sangha data');
  }
}
