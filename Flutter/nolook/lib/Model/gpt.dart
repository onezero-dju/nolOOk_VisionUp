import 'package:http/http.dart' as http;
import 'dart:convert';

class GPTService {
  final String apiKey =
      'sk-proj-jRgKRLisct2GoIYnmfh2T3BlbkFJFDHf2kilZBhKenziSZBn'; // Replace with your actual GPT API Key
  final String apiUrl = 'https://api.openai.com/v1/chat/completions';

  Future<String> getKeywordFromText(String text) async {
    String model = "gpt-3.5-turbo";
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: json.encode({
        'model': model,
        'messages': [
          {'role': 'system', 'content': 'You are a helpful assistant.'},
          {
            'role': 'user',
            'content': 'Extract the most frequent keyword from this text: $text'
          }
        ],
        'max_tokens': 50,
        'temperature': 0.5,
      }),
    );

    print('URL: $apiUrl');
    print('Headers: ${json.encode({
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        })}');
    print('Body: ${json.encode({
          'model': 'gpt-4',
          'messages': [
            {'role': 'system', 'content': 'You are a helpful assistant.'},
            {
              'role': 'user',
              'content':
                  'Extract the most frequent keyword from this text: $text'
            }
          ],
          'max_tokens': 50,
          'temperature': 0.5,
        })}');
    print('Response:');
    print('Status Code: ${response.statusCode}');
    print('Reason Phrase: ${response.reasonPhrase}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['choices'][0]['message']['content'].trim();
    } else {
      throw Exception('Failed to analyze text: ${response.reasonPhrase}');
    }
  }
}
