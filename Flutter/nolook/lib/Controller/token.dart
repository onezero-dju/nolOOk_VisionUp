import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('jwtToken', token);
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwtToken');
}

Future<void> sendRequest() async {
  final token = await getToken();

  if (token == null) {
    print('No token found');
    return;
  }

  final url = Uri.parse('https://your-server-endpoint/api/resource');
  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    print('Request successful');
  } else {
    print('Request failed with status: ${response.statusCode}');
  }
}
