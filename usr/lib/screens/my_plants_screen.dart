import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MyPlantsScreen extends StatefulWidget {
  const MyPlantsScreen({super.key});

  @override
  State<MyPlantsScreen> createState() => _MyPlantsScreenState();
}

class _MyPlantsScreenState extends State<MyPlantsScreen> {
  List<Map<String, dynamic>> _plants = [];

  @override
  void initState() {
    super.initState();
    _fetchPlants();
  }

  Future<void> _fetchPlants() async {
    final userId = Supabase.instance.client.auth.currentUser!.id;
    final response = await Supabase.instance.client.from('plants').select('*').eq('owner_id', userId);
    setState(() {
      _plants = List<Map<String, dynamic>>.from(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Plants'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddPlantDialog(),
          ),
        ],
      ),
      body: _plants.isEmpty
          ? const Center(child: Text('No plants yet. Scan a QR to adopt!'))
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: _plants.length,
              itemBuilder: (context, index) {
                final plant = _plants[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Image.network(plant['image'] ?? 'https://via.placeholder.com/150', height: 100),
                      Text(plant['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text('Mood: ${plant['mood']} ${plant['emoji']}'),
                      Text('Level: ${plant['growth_level']}'),
                    ],
                  ).animate().scale(duration: 300.ms),
                ).onTap(() => _viewPlantProfile(plant));
              },
            ),
    );
  }

  void _showAddPlantDialog() {
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Plant'),
        content: TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Plant Name')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: () async {
            await Supabase.instance.client.from('plants').insert({
              'name': nameController.text,
              'owner_id': Supabase.instance.client.auth.currentUser!.id,
              'mood': 'Happy',
              'emoji': '😊',
              'growth_level': 1,
              'image': 'https://via.placeholder.com/150',
            });
            _fetchPlants();
            Navigator.pop(context);
          }, child: const Text('Add')),
        ],
      ),
    );
  }

  void _viewPlantProfile(Map<String, dynamic> plant) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlantProfileScreen(plant: plant)),
    );
  }
}

class PlantProfileScreen extends StatelessWidget {
  final Map<String, dynamic> plant;
  const PlantProfileScreen({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(plant['name'])),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(plant['image'], height: 200),
            Text('Mood: ${plant['mood']} ${plant['emoji']}', style: const TextStyle(fontSize: 20)),
            Text('Growth Level: ${plant['growth_level']}'),
            ElevatedButton(
              onPressed: () => _careForPlant(context),
              child: const Text('Care for Plant'),
            ),
          ],
        ),
      ),
    );
  }

  void _careForPlant(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Plant cared for! Earned points.')));
  }
}