import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gemini Text Summarizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SummarizeScreen(),
    );
  }
}

class SummarizeScreen extends StatefulWidget {
  const SummarizeScreen({super.key});

  @override
  _SummarizeScreenState createState() => _SummarizeScreenState();
}

class _SummarizeScreenState extends State<SummarizeScreen> {
  final TextEditingController _controller = TextEditingController();
  String _summary = '';
  bool _isLoading = false;
  final GeminiService _geminiService = GeminiService();

  void _summarizeText() async {
    setState(() {
      _isLoading = true;
      _summary = '';
    });

    try {
      String summary = await _geminiService.summarizeText(_controller.text);
      setState(() {
        _summary = summary;
      });
    } catch (error) {
      setState(() {
        _summary = 'Error: $error';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gemini Text Summarizer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter text to summarize',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _summarizeText,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Summarize'),
            ),
            const SizedBox(height: 20),
            Text(
              _summary,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class GeminiService {
  final String apiKey =
      'AIzaSyBl9aJXe7OZcWvorZL7PBaeOIg7PySBrz4'; // 실제 Gemini API 키로 교체
  final String apiUrl =
      'https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent'; // 가상의 API URL

  Future<String> summarizeText(String text) async {
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: json.encode({
        'text': text,
        'summary_length': 'short', // 요약 길이 옵션
      }),
    );

    print('URL: $apiUrl');
    print('Headers: ${json.encode({
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        })}');
    print('Body: ${json.encode({
          'text': text,
          'summary_length': 'short',
        })}');
    print('Response:');
    print('Status Code: ${response.statusCode}');
    print('Reason Phrase: ${response.reasonPhrase}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['summary'].trim();
    } else {
      throw Exception('Failed to summarize text: ${response.reasonPhrase}');
    }
  }
}
