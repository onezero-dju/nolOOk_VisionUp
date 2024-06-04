import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:nolook/Controller/token.dart';

class UserController {
  Future<void> register(String email, String password, String userName) async {
    //유저 등록
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

  Future<bool> login(String email, String password) async {
    final url = Uri.parse(
        'http://nolook.ap-northeast-2.elasticbeanstalk.com/api/user/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      // 서버 응답 전체를 출력하여 확인
      print('Response data: $responseData');

      // 응답 데이터에서 success 필드가 없을 경우를 대비한 처리
      if (responseData != null) {
        if (responseData.containsKey('jwtToken')) {
          String token = responseData['jwtToken'];

          await saveToken(token);
          print('Token received: $token');
          return true;
        } else {
          print('JWT token is missing in the response');
          return false;
        }
      } else {
        print('Response data is null');
        return false;
      }
    } else {
      throw Exception('Failed to login: ${response.reasonPhrase}');
    }
  }
}
