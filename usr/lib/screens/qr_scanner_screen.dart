import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras!.isNotEmpty) {
        _controller = CameraController(_cameras![0], ResolutionPreset.medium);
        await _controller!.initialize();
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      // Handle camera initialization error
      print("Error initializing camera: $e");
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
    try {
      await Supabase.instance.client.from('plants').insert({
        'name': 'New Plant',
        'owner_id': Supabase.instance.client.auth.currentUser!.id,
        'qr_code': plantId,
        'mood': 'Excited',
        'emoji': '🌱',
        'growth_level': 1,
        'image': 'https://via.placeholder.com/150',
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Plant adopted!')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to adopt plant: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan a Plant')),
      body: Column(
        children: [
          Expanded(
            child: _isCameraInitialized
                ? CameraPreview(_controller!)
                : const Center(child: CircularProgressIndicator()),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _isCameraInitialized ? _scanQr : null,
              child: Text(_isScanning ? 'Scanning...' : 'Scan QR'),
            ),
          ),
        ],
      ),
    );
  }
}
