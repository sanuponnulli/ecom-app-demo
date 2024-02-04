import 'dart:developer';

import 'package:assignmentecom/data/service/client.dart';
import 'package:http/http.dart' as http;

class MyRepository {
  final MyHttpClient _httpClient;

  MyRepository({required MyHttpClient httpClient}) : _httpClient = httpClient;

  Future<http.Response> fetchData() async {
    try {
      final data = await _httpClient.get('products');
      log("REPO");
      // Update endpoint
      return data;
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<dynamic> postData(dynamic body) async {
    try {
      final response = await _httpClient.post('data', body);
      return response;
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }

  // Add more methods for other endpoints as needed
}
