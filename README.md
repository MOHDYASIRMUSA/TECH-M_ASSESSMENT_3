# 🏋️‍♂️ Fitness Tracker App

A simple Flutter mobile app that helps users log their workouts, calculate BMI, and view activity summaries. Built as part of the **Tech Mahindra Assessment**.

---

## 📱 Features

### ✅ Workout Logging
- Add workouts with:
  - Title (e.g., Push-ups)
  - Category (Cardio, Strength, Yoga, etc.)
  - Duration (in minutes)
  - Date

### 📋 Workout List
- Home screen displays all logged workouts
- Each card shows:
  - Workout title
  - Category icon
  - Duration
  - Date

### 📊 Summary Report
- View total number of workouts by category
- Displays basic stats with count display
- (Optional) Weekly view available

### ⚖️ BMI Calculator
- Input height (cm) and weight (kg)
- Calculates and displays BMI value
- Shows health status (Underweight, Normal, Overweight)

---

## 🧱 Project Structure

lib/
┣ models/
┃ ┗ workout_model.dart
┣ screens/
┃ ┣ home_screen.dart
┃ ┣ add_workout_screen.dart
┃ ┣ bmi_screen.dart
┃ ┗ summary_screen.dart
┣ widgets/
┃ ┣ workout_card.dart
┃ ┗ category_selector.dart
┣ utils/
┃ ┗ constants.dart
┣ services/
┃ ┗ storage_service.dart
┗ main.dart

## 🛠️ Tech Stack

- **Flutter** (UI Toolkit)
- **Dart** (Programming Language)
- **State Management:** setState
- **Local Storage:** (Optional) `shared_preferences` or JSON (currently in-memory only)

---

## 🚀 Getting Started

1. **Clone the Repo**

git clone https://github.com/yourusername/fitness-tracker-app.git
cd fitness-tracker-app

Run the App

flutter pub get
flutter run

Author
Yasir Musa
For Tech Mahindra Assessment – Mobile App Track

