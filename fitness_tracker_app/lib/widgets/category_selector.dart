// lib/widgets/category_selector.dart

import 'package:flutter/material.dart';
import '../models/workout_model.dart';

class CategorySelector extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = Workout.categories;

    return Wrap(
      spacing: 12,
      children: categories.map((cat) {
        final isSelected = cat == selectedCategory;
        return ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Workout.getCategoryIcon(cat), size: 20),
              const SizedBox(width: 6),
              Text(cat),
            ],
          ),
          selected: isSelected,
          selectedColor: Colors.teal,
          onSelected: (_) => onCategorySelected(cat),
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
          ),
        );
      }).toList(),
    );
  }
}
