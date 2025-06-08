// lib/services/storage_service.dart

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/workout_model.dart';

class StorageService {
  static const String workoutsKey = 'workouts';

  // Save a workout entry
  static Future<void> saveWorkout(Workout workout) async {
    final prefs = await SharedPreferences.getInstance();
    final workoutsString = prefs.getString(workoutsKey);
    List<Map<String, dynamic>> workouts = [];

    if (workoutsString != null) {
      final List<dynamic> decoded = jsonDecode(workoutsString);
      workouts = decoded.cast<Map<String, dynamic>>();
    }

    workouts.add(workout.toMap());

    await prefs.setString(workoutsKey, jsonEncode(workouts));
  }

  // Get all stored workouts
  static Future<List<Workout>> getWorkouts() async {
    final prefs = await SharedPreferences.getInstance();
    final workoutsString = prefs.getString(workoutsKey);

    if (workoutsString == null) return [];

    final List<dynamic> decoded = jsonDecode(workoutsString);
    return decoded.map((map) => Workout.fromMap(map)).toList();
  }

  // Clear all workouts (optional)
  static Future<void> clearWorkouts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(workoutsKey);
  }
}
