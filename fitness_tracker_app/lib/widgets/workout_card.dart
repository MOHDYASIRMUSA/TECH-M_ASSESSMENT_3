// lib/widgets/workout_card.dart

import 'package:flutter/material.dart';
import '../models/workout_model.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;

  const WorkoutCard({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        leading: Icon(
          Workout.getCategoryIcon(workout.category),
          size: 32,
          color: Colors.teal,
        ),
        title: Text(
          workout.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
            '${workout.category} • ${workout.duration} min • ${_formatDate(workout.date)}'),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
