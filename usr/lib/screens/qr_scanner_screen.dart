import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras!.isNotEmpty) {
      _controller = CameraController(_cameras![0], ResolutionPreset.medium);
      await _controller!.initialize();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _scanQr() async {
    if (_isScanning) return;
    setState(() => _isScanning = true);
    // Simulate QR scan (in real app, use qr_code_scanner package)
    await Future.delayed(const Duration(seconds: 2));
    final plantId = 'sample_plant_${DateTime.now().millisecondsSinceEpoch}';
    await _adoptPlant(plantId);
    setState(() => _isScanning = false);
  }

  Future<void> _adoptPlant(String plantId) async {
    await Supabase.instance.client.from('plants').insert({
      'name': 'New Plant',
      'owner_id': Supabase.instance.client.auth.currentUser!.id,
      'qr_code': plantId,
      'mood': 'Excited',
      'emoji': '🌱',
      'growth_level': 1,
      'image': 'https://via.placeholder.com/150',
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Plant adopted!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan a Plant')),
      body: Column(
        children: [
          if (_controller != null && _controller!.value.isInitialized)
            CameraPreview(_controller!),
          ElevatedButton(
            onPressed: _scanQr,
            child: Text(_isScanning ? 'Scanning...' : 'Scan QR'),
          ),
        ],
      ),
    );
  }
}