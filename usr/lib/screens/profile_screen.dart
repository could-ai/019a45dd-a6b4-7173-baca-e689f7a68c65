import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? _user;
  List<Map<String, dynamic>> _achievements = [];
  List<Map<String, dynamic>> _moods = [];

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    final userId = Supabase.instance.client.auth.currentUser!.id;
    final userResponse = await Supabase.instance.client.from('users').select('*').eq('id', userId).single();
    final achievementsResponse = await Supabase.instance.client.from('achievements').select('*').eq('user_id', userId);
    final moodsResponse = await Supabase.instance.client.from('mood_logs').select('*').eq('user_id', userId);
    setState(() {
      _user = userResponse;
      _achievements = List<Map<String, dynamic>>.from(achievementsResponse);
      _moods = List<Map<String, dynamic>>.from(moodsResponse);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) return const Center(child: CircularProgressIndicator());
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(radius: 50, backgroundImage: NetworkImage(_user!['avatar'] ?? 'https://via.placeholder.com/150')),
            Text(_user!['name'], style: const TextStyle(fontSize: 24)),
            Text('Points: ${_user!['points']} | Level: ${_user!['level']}'),
            const SizedBox(height: 20),
            Text('Achievements:', style: const TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: _achievements.length,
                itemBuilder: (context, index) {
                  final achievement = _achievements[index];
                  return ListTile(
                    title: Text(achievement['badge_type']),
                  ).animate().fadeIn();
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => _logMood(),
              child: const Text('Log Mood'),
            ),
          ],
        ),
      ),
    );
  }

  void _logMood() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Mood'),
        content: TextField(controller: controller, decoration: const InputDecoration(labelText: 'How are you feeling?')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: () async {
            await Supabase.instance.client.from('mood_logs').insert({
              'user_id': Supabase.instance.client.auth.currentUser!.id,
              'mood': controller.text,
              'date': DateTime.now().toIso8601String(),
            });
            _fetchProfile();
            Navigator.pop(context);
          }, child: const Text('Log')),
        ],
      ),
    );
  }
}