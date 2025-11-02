import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PulseFeedScreen extends StatefulWidget {
  const PulseFeedScreen({super.key});

  @override
  State<PulseFeedScreen> createState() => _PulseFeedScreenState();
}

class _PulseFeedScreenState extends State<PulseFeedScreen> {
  List<Map<String, dynamic>> _posts = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    final response = await Supabase.instance.client.from('plant_posts').select('*').order('created_at', ascending: false);
    setState(() {
      _posts = List<Map<String, dynamic>>.from(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pulse Feed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddPostDialog(),
          ),
        ],
      ),
      body: _posts.isEmpty
          ? const Center(child: Text('No posts yet. Add some plants!'))
          : ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(post['image'] ?? 'https://via.placeholder.com/150'),
                    ),
                    title: Text(post['content']),
                    subtitle: Text('By ${post['user_id']} • ${post['created_at']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.thumb_up),
                      onPressed: () => _likePost(post['id']),
                    ),
                  ).animate().fadeIn(duration: 500.ms),
                );
              },
            ),
    );
  }

  void _showAddPostDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Post'),
        content: TextField(controller: controller, decoration: const InputDecoration(labelText: 'Share your plant update')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: () async {
            await Supabase.instance.client.from('plant_posts').insert({
              'user_id': Supabase.instance.client.auth.currentUser!.id,
              'content': controller.text,
              'image': 'https://via.placeholder.com/150',
            });
            _fetchPosts();
            Navigator.pop(context);
          }, child: const Text('Post')),
        ],
      ),
    );
  }

  Future<void> _likePost(int id) async {
    // Simulate like (in real app, update a likes table)
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Liked!')));
  }
}