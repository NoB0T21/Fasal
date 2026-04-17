import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/api/http_client.dart';

class BackendApiClient {
  final String baseurl = dotenv.env['BACKEND_URL']!;
  final CookieClient client = CookieClient();
  final _storage = FlutterSecureStorage();
  
  Future<Map<String, dynamic>> getOTP(String phoneNumber) async {
    final url = '$baseurl/api/v1/auth/get-OTP';
    final response = await client.post(
      Uri.parse(url), 
      headers:{'Content-Type': 'application/json',},
      body: jsonEncode({'phone': phoneNumber})
    );

    final responseBody = jsonDecode(response.body);
    print(responseBody);
    if(response.statusCode != 200){
      throw Exception('Something went wrong');
    }
    return responseBody;
  }

  Future<Map<String, dynamic>> verifyOTP(String phoneNumber, String otp) async {
    final url = '$baseurl/api/v1/auth/verify-OTP';
    final response = await client.post(
      Uri.parse(url), 
      headers:{'Content-Type': 'application/json',},
      body: jsonEncode({'phone': phoneNumber, 'otp': otp})
    );

    final responseBody = jsonDecode(response.body);
    if(response.statusCode != 200){
      throw Exception('Something went wrong');
    }
    if (response.statusCode == 200) {
      String? rawCookie = response.headers['set-cookie'];
      
      if (rawCookie != null) {
        await _storage.write(key: 'session_cookie', value: rawCookie);
      }
    }
    return responseBody;
  }

  Future<Map<String, dynamic>> verifyUser() async {
    final url = '$baseurl/api/v1/auth/verify';
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
      },
    );

    final responseBody = jsonDecode(response.body);
    return responseBody;
  }

  Future<Map<String, dynamic>> logoutUser() async {
    final url = '$baseurl/api/v1/auth/logout';
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
      },
    );

    final responseBody = jsonDecode(response.body);
    if(response.statusCode != 200){
      throw Exception('Something went wrong');
    }
    _storage.delete(key: 'session_cookie');
    return responseBody;
  }

  Future<Map<String, dynamic>> getDashboardData(String soil, String lat, String lon) async {
    final url = '$baseurl/api/v1/dashboard/get-data';
    final response = await client.post(
      Uri.parse(url),
      headers:{'Content-Type': 'application/json',},
      body: jsonEncode({
        "soil": soil,
        "location": {
          "lat": lat,
          "lon": lon
        }
      })
    );
    print(response.headers);
    final responseBody = jsonDecode(response.body);
    return responseBody;
  }
}