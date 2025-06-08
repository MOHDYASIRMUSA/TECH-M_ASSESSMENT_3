// lib/screens/bmi_screen.dart

import 'package:flutter/material.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final _formKey = GlobalKey<FormState>();

  double _weight = 0;
  double _height = 0;
  double? _bmi;
  String _status = '';

  void _calculateBmi() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final heightInMeters = _height / 100;
      final bmi = _weight / (heightInMeters * heightInMeters);

      String status;
      if (bmi < 18.5) {
        status = 'Underweight';
      } else if (bmi < 25) {
        status = 'Normal';
      } else if (bmi < 30) {
        status = 'Overweight';
      } else {
        status = 'Obese';
      }

      setState(() {
        _bmi = bmi;
        _status = status;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Weight (kg)'),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Enter your weight';
                  }
                  if (double.tryParse(val) == null || double.parse(val) <= 0) {
                    return 'Enter valid weight';
                  }
                  return null;
                },
                onSaved: (val) => _weight = double.parse(val!),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Height (cm)'),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Enter your height';
                  }
                  if (double.tryParse(val) == null || double.parse(val) <= 0) {
                    return 'Enter valid height';
                  }
                  return null;
                },
                onSaved: (val) => _height = double.parse(val!),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _calculateBmi,
                child: const Text('Calculate BMI'),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14)),
              ),
              if (_bmi != null) ...[
                const SizedBox(height: 24),
                Text(
                  'Your BMI is: ${_bmi!.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Status: $_status',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
