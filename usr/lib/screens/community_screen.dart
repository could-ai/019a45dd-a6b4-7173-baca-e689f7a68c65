import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  // Mock data for communities
  final List<Map<String, dynamic>> _communities = [
    {"id": 1, "name": "Downtown Plant Squad", "members": 124},
    {"id": 2, "name": "Rooftop Gardeners NYC", "members": 88},
    {"id": 3, "name": "Office Plant Parents", "members": 32},
    {"id": 4, "name": "Balcony Bloomers", "members": 76},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Green Communities'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Placeholder for the Community Map
          Container(
            height: 250,
            color: Theme.of(context).cardTheme.color,
            child: const Center(
              child: Text(
                'Community Map (Placeholder)',
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ),
          // List of communities
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _communities.length,
              itemBuilder: (context, index) {
                final community = _communities[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                      child: Icon(
                        Icons.people_alt_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    title: Text(
                      community['name'],
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 18),
                    ),
                    subtitle: Text('${community['members']} members'),
                    trailing: ElevatedButton(
                      onPressed: () => _joinCommunity(community['id']),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                      ),
                      child: const Text('Join'),
                    ),
                  ),
                ).animate().fadeIn(delay: (100 * index).ms).slideX(begin: -0.5);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _joinCommunity(int id) {
    // In a real app, this would call the database to join the community
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Joined community!'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
