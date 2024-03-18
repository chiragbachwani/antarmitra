import 'dart:convert';
import 'package:antarmitra/controller/homecontroller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

void fetchApiCode() async {
  var controller = Get.put(homeController());
  final url = 'http://13.48.136.54:8000/api/api-code/';
  final accessKey = '31dff60a-a0ab-4dd9-818c-351d2b045642';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $accessKey'},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      String apiCodeFromResponse = responseData['api_code'];
      controller.apiCode.value = apiCodeFromResponse;
      print('API Code: ${controller.apiCode.value}');
    } else {
      print('Failed to fetch API code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
