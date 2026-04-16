import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CookieClient extends http.BaseClient {
  final http.Client _inner = http.Client();
  final _storage = const FlutterSecureStorage();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    String? cookie = await _storage.read(key: 'session_cookie');
    
    if (cookie != null) {
      request.headers['Cookie'] = cookie;
    }

    final response = await _inner.send(request);

    final String? setCookie = response.headers['set-cookie'];
    if (setCookie != null) {
      await _storage.write(key: 'session_cookie', value: setCookie);
    }
    if (response.statusCode == 401) {
      await _storage.delete(key: 'session_cookie');
    }
    return response;
  }
}