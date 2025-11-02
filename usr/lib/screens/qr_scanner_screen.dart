import 'package:flutter/material.dart';

class QrScannerScreen extends StatelessWidget {
  const QrScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan a Plant'),
      ),
      body: const Center(
        child: Text(
          'QR Scanner Screen - Coming Soon!',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
