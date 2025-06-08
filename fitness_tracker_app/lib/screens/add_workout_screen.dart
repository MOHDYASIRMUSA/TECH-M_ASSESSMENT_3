// lib/screens/add_workout_screen.dart

import 'package:flutter/material.dart';
import '../models/workout_model.dart';
import '../services/storage_services.dart';
import '../widgets/category_selector.dart';

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({super.key});

  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _category = 'Cardio';
  int _duration = 0;
  DateTime _selectedDate = DateTime.now();

  Future<void> _saveWorkout() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final workout = Workout(
        title: _title,
        category: _category,
        duration: _duration,
        date: _selectedDate,
      );

      await StorageService.saveWorkout(workout);
      Navigator.pop(context, true);
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Workout'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Workout Title'),
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Enter title' : null,
                onSaved: (val) => _title = val!.trim(),
              ),
              const SizedBox(height: 12),
              Text('Category', style: Theme.of(context).textTheme.titleMedium),
              CategorySelector(
                selectedCategory: _category,
                onCategorySelected: (val) {
                  setState(() {
                    _category = val;
                  });
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Duration (minutes)',
                  hintText: 'Enter workout duration',
                ),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Enter duration';
                  }
                  if (int.tryParse(val) == null || int.parse(val) <= 0) {
                    return 'Enter valid positive number';
                  }
                  return null;
                },
                onSaved: (val) => _duration = int.parse(val!),
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Date'),
                subtitle: Text(
                    '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _pickDate,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveWorkout,
                child: const Text('Save Workout'),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
