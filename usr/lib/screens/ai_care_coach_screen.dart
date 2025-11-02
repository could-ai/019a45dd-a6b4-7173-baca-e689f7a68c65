import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AiCareCoachScreen extends StatefulWidget {
  const AiCareCoachScreen({super.key});

  @override
  State<AiCareCoachScreen> createState() => _AiCareCoachScreenState();
}

class _AiCareCoachScreenState extends State<AiCareCoachScreen> {
  final _messageController = TextEditingController();
  List<String> _chat = ['Hello! How can I help with your plants today?'];

  Future<void> _sendMessage() async {
    final message = _messageController.text;
    setState(() => _chat.add('You: $message'));
    _messageController.clear();
    // Simulate AI response (replace with Edge Function call)
    final response = await _getAiResponse(message);
    setState(() => _chat.add('Coach: $response'));
  }

  Future<String> _getAiResponse(String query) async {
    // Placeholder for GPT integration via Supabase Edge Function
    return 'Based on your query "$query", try watering your plant more! 🌿';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Care Coach')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _chat.length,
              itemBuilder: (context, index) => ListTile(title: Text(_chat[index])),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(labelText: 'Ask about your plants'),
                  ),
                ),
                IconButton(icon: const Icon(Icons.send), onPressed: _sendMessage),
              ],
            ),
          ),
        ],
      ),
    );
  }
}