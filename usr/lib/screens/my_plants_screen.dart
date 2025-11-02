import 'package:flutter/material.dart';

class MyPlantsScreen extends StatelessWidget {
  const MyPlantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Plants'),
      ),
      body: const Center(
        child: Text(
          'My Plants Screen - Coming Soon!',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
