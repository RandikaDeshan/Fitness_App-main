import 'package:fitness_app/models/exercisesmodel.dart';
import 'package:flutter/material.dart';

class ExerciseProvider extends ChangeNotifier {
  List<ExercisesModel> _allExercises = [];
  List<ExercisesModel> exercises = [];

  ExerciseProvider() {
    _allExercises = [
      ExercisesModel(
          id: 1, name: "Bench Press", imageUrl: "", description: "description"),
      ExercisesModel(
          id: 2,
          name: "Dicline Press",
          imageUrl: "",
          description: "description"),
    ];
    exercises = List.from(_allExercises);
  }
}
