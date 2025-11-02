import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Green Communities'),
      ),
      body: const Center(
        child: Text(
          'Community Screen - Coming Soon!',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
