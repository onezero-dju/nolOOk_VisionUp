import 'package:http/http.dart' as http;
import 'dart:convert';

class DirectoryController {
  Future<List<String>> fetchDirList() async {
    final url = Uri.parse(
        'http://nolook.ap-northeast-2.elasticbeanstalk.com/api/directory/list'); // API 엔드포인트 변경
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJnaWhvbmcwNDA4QGdtYWlsLmNvbSIsImlhdCI6MTcxNzQyNzcwNiwiZXhwIjoxNzE3NTE0MTA2fQ.MraOFnlFRcMUtQZptAYnSMjZM3a_vXRLTFbkBdBpkCg'
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

  Future<void> createFile(String fileName) async {
    final url = Uri.parse(
        'http://nolook.ap-northeast-2.elasticbeanstalk.com/api/user/createFile'); // 파일 생성 API 엔드포인트
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        // 필요한 경우 인증 헤더 추가
        // 'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
      },
      body: jsonEncode({
        'file_name': fileName,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create file: ${response.reasonPhrase}');
    }
  }
}
