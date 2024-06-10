import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatGPT App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  String model = "gpt-3.5-turbo";
  Future<void> _sendMessage(String message) async {
    setState(() {
      _messages.add({'sender': 'user', 'message': message});
    });

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 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',
      },
      body: json.encode({
        'model': model,
        'prompt': message,
        'max_tokens': 150,
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final reply = data['choices'][0]['text'].trim();

      setState(() {
        _messages.add({'sender': 'bot', 'message': reply});
      });
    } else {
      setState(() {
        _messages.add(
            {'sender': 'bot', 'message': 'Failed to get response from API'});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatGPT App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(
                    message['message']!,
                    style: TextStyle(
                      color: message['sender'] == 'user'
                          ? Colors.blue
                          : Colors.black,
                    ),
                  ),
                  subtitle: Text(message['sender']!),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter your message',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final message = _controller.text;
                    _controller.clear();
                    _sendMessage(message);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
