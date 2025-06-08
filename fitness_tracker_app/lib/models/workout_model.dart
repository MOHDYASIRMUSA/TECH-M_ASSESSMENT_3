// lib/models/workout_model.dart

import 'package:flutter/material.dart';

class Workout {
  final String title;
  final String category;
  final int duration; // in minutes
  final DateTime date;

  Workout({
    required this.title,
    required this.category,
    required this.duration,
    required this.date,
  });

  // Convert Workout object to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'category': category,
      'duration': duration,
      'date': date.toIso8601String(),
    };
  }

  // Create Workout from Map
  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      title: map['title'],
      category: map['category'],
      duration: map['duration'],
      date: DateTime.parse(map['date']),
    );
  }

  static const List<String> categories = [
    'Cardio',
    'Strength',
    'Flexibility',
    'Balance',
    // Add more categories as needed
  ];

  // Get category icon for UI
  static IconData getCategoryIcon(String category) {
    switch (category) {
      case 'Cardio':
        return Icons.directions_run;
      case 'Strength':
        return Icons.fitness_center;
      case 'Flexibility':
        return Icons.self_improvement;
      case 'Balance':
        return Icons.accessibility_new;
      default:
        return Icons.fitness_center;
    }
  }
}
