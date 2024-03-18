import 'package:http/http.dart' as http;

void fetchApiCode(String apiCode) async {
  final url = 'http://13.48.136.54:8000/api/api-code/';
  final accessKey = '31dff60a-a0ab-4dd9-818c-351d2b045642';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $accessKey'},
    );

    if (response.statusCode == 200) {
     apiCode = response.body;

      print(response.body);
    } else {
      print('Failed to fetch API code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
