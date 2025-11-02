import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  List<Map<String, dynamic>> _communities = [];

  @override
  void initState() {
    super.initState();
    _fetchCommunities();
  }

  Future<void> _fetchCommunities() async {
    final response = await Supabase.instance.client.from('communities').select('*');
    setState(() {
      _communities = List<Map<String, dynamic>>.from(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Green Communities')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _communities.length,
              itemBuilder: (context, index) {
                final community = _communities[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(community['name']),
                    subtitle: Text('${community['members']} members'),
                    trailing: ElevatedButton(
                      onPressed: () => _joinCommunity(community['id']),
                      child: const Text('Join'),
                    ),
                  ).animate().slideInFromLeft(),
                );
              },
            ),
          ),
          Container(
            height: 200,
            color: Colors.grey[800],
            child: const Center(child: Text('Community Map (Placeholder - Use Google Maps API)')),
          ),
        ],
      ),
    );
  }

  Future<void> _joinCommunity(int id) async {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Joined community!')));
  }
}