import 'package:http/http.dart' as http;
import 'dart:convert';

class UserController {
  Future<void> register(String email, String password, String userName) async {
    final url = Uri.parse(
        'http://nolook.ap-northeast-2.elasticbeanstalk.com/api/user/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'email': email, 'password': password, 'user_name': userName}),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['success']) {
        // 회원가입 성공 처리
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception('Failed to register: ${response.reasonPhrase}');
    }
  }

  Future<void> login(String email, String password) async {
    final url = Uri.parse(
        'http://nolook.ap-northeast-2.elasticbeanstalk.com/api/user/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['success']) {
        // 로그인 성공 처리
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception('Failed to login');
    }
  }
}
