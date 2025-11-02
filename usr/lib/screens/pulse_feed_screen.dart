import 'package:flutter/material.dart';

class PulseFeedScreen extends StatelessWidget {
  const PulseFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pulse Feed'),
      ),
      body: const Center(
        child: Text(
          'Pulse Feed Screen - Coming Soon!',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
