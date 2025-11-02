import 'package:flutter/material.dart';

class ArModeScreen extends StatelessWidget {
  const ArModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AR Mode')),
      body: const Center(child: Text('AR visualization coming soon! (Integrate ARCore/ARKit)')),
    );
  }
}