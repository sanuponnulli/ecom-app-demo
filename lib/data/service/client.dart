import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class MyHttpClient {
  final String baseUrl;

  MyHttpClient({required this.baseUrl});

  Future<http.Response> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
    // log(response.body, name: 'response');
    final temp = _handleResponse(response);
    // log(temp.toString(), name: 'temp');
    return temp;
  }

  Future<dynamic> post(String endpoint, dynamic body) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  http.Response _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
