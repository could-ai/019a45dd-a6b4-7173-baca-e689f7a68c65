import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EcoQuestsScreen extends StatefulWidget {
  const EcoQuestsScreen({super.key});

  @override
  State<EcoQuestsScreen> createState() => _EcoQuestsScreenState();
}

class _EcoQuestsScreenState extends State<EcoQuestsScreen> {
  List<String> _quests = ['Water a plant nearby', 'Take a photo of a sprout', 'Adopt a new plant'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Eco Quests')),
      body: ListView.builder(
        itemCount: _quests.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(_quests[index]),
          trailing: ElevatedButton(onPressed: () => _completeQuest(index), child: const Text('Complete')),
        ),
      ),
    );
  }

  void _completeQuest(int index) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Quest completed! Earned points.')));
  }
}