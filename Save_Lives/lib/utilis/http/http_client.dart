// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:http/http.dart' as http;

class THttpHelper {
  static const  String _baseUrl = 'https://api.example.com';

  static Future<Map<String , dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response);
  }
  static Future<Map<String , dynamic>> post(String endpoint, dynamic data) async {
    final response = await http.post(Uri.parse('$_baseUrl/$endpoint'), 
    body: json.encode(data),
    headers: {'Content-Type': 'application/json'},
    );
    return _handleResponse(response);
  }
    static Future<Map<String , dynamic>> put(String endpoint, dynamic data) async {
    final response = await http.post(Uri.parse('$_baseUrl/$endpoint'), 
    body: json.encode(data),
    headers: {'Content-Type': 'application/json'},
    );
    return _handleResponse(response);
  }
  static Map<String , dynamic> _handleResponse(http.Response response) {
    if(response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data from server ${response.statusCode}');
    }
  }
  // Add more methods for PUT, DELETE, etc. as needed
}
