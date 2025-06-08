// lib/screens/summary_screen.dart

import 'package:flutter/material.dart';
import '../models/workout_model.dart';
import '../services/storage_services.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  Map<String, int> categoryCounts = {};
  int totalWorkouts = 0;

  @override
  void initState() {
    super.initState();
    _loadSummary();
  }

  Future<void> _loadSummary() async {
    final workouts = await StorageService.getWorkouts();

    final Map<String, int> counts = {};
    for (var workout in workouts) {
      counts[workout.category] = (counts[workout.category] ?? 0) + 1;
    }

    setState(() {
      categoryCounts = counts;
      totalWorkouts = workouts.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Summary'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: totalWorkouts == 0
            ? const Center(child: Text('No workouts logged yet.'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Workouts: $totalWorkouts',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Workouts by Category:',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  ...categoryCounts.entries.map(
                    (entry) => ListTile(
                      leading: Icon(
                        Workout.getCategoryIcon(entry.key),
                        color: Colors.teal,
                      ),
                      title: Text('${entry.key}: ${entry.value}'),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
