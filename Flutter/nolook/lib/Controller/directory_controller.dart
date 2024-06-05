import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:nolook/Controller/token.dart';

class DirectoryController {
  Future<List<String>> fetchDirList() async {
    //전체 디렉터리 열람
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

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData is List) {
        List<String> dirList = responseData
            .map<String>((item) => item['directoryName'].toString())
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
        'http://nolook.ap-northeast-2.elasticbeanstalk.com/api/directory/list'); // 파일 생성 API 엔드포인트

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

  Future<void> viewDirectory(String directoryId) async {
    //디렉터리 열람 (메모들 열람)
    final url = Uri.parse(
        'http://nolook.ap-northeast-2.elasticbeanstalk.com/api/directory/view'); // 파일 생성 API 엔드포인트
    final token = await getToken(); // 토큰을 비동기로 가져옴

    print(token);

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
    print(response.statusCode);
    print(response.reasonPhrase);
    print('resopnse body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to create file: ${response.reasonPhrase}');
    }
  }

  Future<void> saveMemo(
      String directoryId, String memoName, String content) async {
    //디렉터리 열람 (메모들 열람)
    final url = Uri.parse(
        'http://nolook.ap-northeast-2.elasticbeanstalk.com/api/momo/save'); // 파일 생성 API 엔드포인트
    final token = await getToken(); // 토큰을 비동기로 가져옴

    print(token);

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "directory_id": directoryId,
        "memo_name": memoName,
        "content": content,
      }),
    );
    print(response.statusCode);
    print(response.reasonPhrase);
    print('resopnse body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to create file: ${response.reasonPhrase}');
    }
  }
}
