// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import '../models/workout_model.dart';
import '../services/storage_services.dart';
import '../widgets/workout_card.dart';
import 'add_workout_screen.dart';
import 'bmi_screen.dart';
import 'summary_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Workout> workouts = [];

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  Future<void> _loadWorkouts() async {
    final loadedWorkouts = await StorageService.getWorkouts();
    setState(() {
      workouts = loadedWorkouts;
    });
  }

  Future<void> _navigateToAddWorkout() async {
    final added = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddWorkoutScreen()),
    );
    if (added == true) {
      _loadWorkouts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Tracker'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SummaryScreen()),
              );
            },
            tooltip: 'Summary',
          ),
          IconButton(
            icon: const Icon(Icons.monitor_weight),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BmiScreen()),
              );
            },
            tooltip: 'BMI Calculator',
          ),
        ],
      ),
      body: workouts.isEmpty
          ? const Center(child: Text('No workouts logged yet.'))
          : RefreshIndicator(
              onRefresh: _loadWorkouts,
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 12),
                itemCount: workouts.length,
                itemBuilder: (context, index) {
                  return WorkoutCard(workout: workouts[index]);
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddWorkout,
        child: const Icon(Icons.add),
        tooltip: 'Add Workout',
      ),
    );
  }
}
