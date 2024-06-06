import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:nolook/Controller/token.dart';

class DirectoryController with ChangeNotifier {
  final List<Map<String, dynamic>> _dirList = [];

  List<Map<String, dynamic>> get dirList => _dirList;
  Future<List<Map<String, dynamic>>> fetchDirList() async {
    final url = Uri.parse(
        'http://nolook.ap-northeast-2.elasticbeanstalk.com/api/directory/list'); // API 엔드포인트 변경
    final token = await getToken(); // 토큰을 비동기로 가져옴

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData is List) {
        List<Map<String, dynamic>> dirList = responseData
            .map<Map<String, dynamic>>((item) =>
                {'id': item['id'], 'directoryName': item['directoryName']})
            .toList();
        return dirList;
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load dir_list: ${response.reasonPhrase}');
    }
  }

  Future<void> createDirectory(String directoryName) async {
    final url = Uri.parse(
        'http://nolook.ap-northeast-2.elasticbeanstalk.com/api/directory/save'); // 파일 생성 API 엔드포인트

    final token = await getToken(); // 토큰을 비동기로 가져옴

    if (token == null || token.isEmpty) {
      throw Exception('Token is missing or empty');
    }

    print('Token: $token'); // 토큰 출력
    print('Directory Name: $directoryName'); // 디렉토리 이름 출력

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'directory_name': directoryName,
      }),
    );

    await saveToken(token);
    print('Response status: ${response.statusCode}');
    print('Response reason: ${response.reasonPhrase}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to create file: ${response.reasonPhrase}');
    }
  }

  Future<List<dynamic>> viewDirectory(int directoryId) async {
    final url = Uri.parse(
        'http://nolook.ap-northeast-2.elasticbeanstalk.com/api/directory/view');
    final token = await getToken();

    // 추가된 디버깅 정보
    print('Sending request to view directory with ID: $directoryId');
    print('Token: $token');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "directory_id": directoryId,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response reason: ${response.reasonPhrase}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to view directory: ${response.reasonPhrase}');
    }

    return List<dynamic>.from(jsonDecode(response.body));
  }

  Future<void> saveMemo(int directoryId, String title, String content) async {
    final url = Uri.parse(
        'http://nolook.ap-northeast-2.elasticbeanstalk.com/api/memo/save');
    final token = await getToken();

    if (token == null || token.isEmpty) {
      throw Exception('Token is missing or empty');
    }

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'directory_id': directoryId,
        'memo_name': title,
        'content': content,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to save memo: ${response.reasonPhrase}');
    }
  }

  Future<void> deleteDirectory(int directoryId) async {
    final url = Uri.parse(
        'http://nolook.ap-northeast-2.elasticbeanstalk.com/api/directory/delete');
    final token = await getToken();

    if (token == null || token.isEmpty) {
      throw Exception('Token is missing or empty');
    }

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'directory_id': directoryId,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete memo: ${response.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> viewMemo(int memoId) async {
    final url = Uri.parse(
        'http://nolook.ap-northeast-2.elasticbeanstalk.com/api/memo/view');
    final token = await getToken();

    print('Sending request to view memo with ID: $memoId');
    print('Token: $token');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "memo_id": memoId,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response reason: ${response.reasonPhrase}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to view memo: ${response.reasonPhrase}');
    }

    // JSON 파싱
    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}
