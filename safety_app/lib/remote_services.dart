import 'dart:convert';
import 'package:flutter_app/utils/api_client.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  // static const String baseUrl =
  //     "http://192.168.1.72/Kumar/KumarProperties/api/v1/"; // WIFI
  static const String baseUrl =
      "http://34.133.129.206/stagging/api/v1/"; //stagging

  // Method to get headers with or without token
  static Map<String, String> getHeaders({bool includeAuth = true}) {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (includeAuth) {
      String token = ApiClient.gs.read('token') ?? '';
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  // Get Method for calling APIs
  static Future<http.Response> fetchGetData(String url) async {
    print('$baseUrl$url');
    print('Token: ${ApiClient.gs.read('token')}');
    try {
      var response = await http.get(
        Uri.parse('$baseUrl$url'),
        headers: getHeaders(),
      );
      return response;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  // Post Method for calling APIs
  static Future<http.Response> postMethod(
      String url, Map<String, dynamic> map) async {
    print('$baseUrl$url');
    print("Request body: ${jsonEncode(map)}");
    try {
      var response = await http.post(
        Uri.parse('$baseUrl$url'),
        headers:
            getHeaders(includeAuth: false), // No token for POST in some cases
        body: jsonEncode(map),
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  // Post Method with Token for calling APIs
  static Future<http.Response> postMethodWithToken(
      String url, Map<String, dynamic> map) async {
    print('$baseUrl$url');
    print('Token: ${ApiClient.gs.read('token')}');
    print("Request body: ${jsonEncode(map)}");
    var header = {
      'Authorization': '${ApiClient.gs.read('token')}',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    try {
      var response = await http.post(
        Uri.parse('$baseUrl$url'),
        headers: header,
        body: jsonEncode(map),
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  // Put Method for calling APIs
  static Future<http.Response> fetchPutData(
      Map<String, dynamic> map, String url) async {
    print('$baseUrl$url');
    try {
      var response = await http.put(
        Uri.parse('$baseUrl$url'),
        headers: getHeaders(), // Using headers with token
        body: jsonEncode(map),
      );
      return response;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  // Delete Method for calling APIs
  static Future<http.Response> deleteData(
      Map<String, dynamic> map, String url) async {
    print('$baseUrl$url');
    try {
      var response = await http.delete(
        Uri.parse('$baseUrl$url'),
        headers: getHeaders(), // Using headers with token
        body: jsonEncode(map),
      );
      return response;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  //----------------------
}
