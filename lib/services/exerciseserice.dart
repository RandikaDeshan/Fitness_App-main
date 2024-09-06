import 'dart:convert';
import 'package:fitness_app/models/exercisesmodel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExerciseService {
  List<ExercisesModel> exeicisesList = [];
  static const String _userKey = "exercises";

  Future<void> saveExercises(
      ExercisesModel exercisesmodel, BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? existingExercises = pref.getStringList(_userKey);

      List<ExercisesModel> existingExerciseObjects = [];

      if (existingExercises != null) {
        existingExerciseObjects = existingExercises
            .map((e) => ExercisesModel.fromJson(jsonDecode(e)))
            .toList();
      }

      existingExerciseObjects.add(exercisesmodel);

      List<String>? updatedExercises =
          existingExerciseObjects.map((e) => jsonEncode(e.toJson())).toList();

      await pref.setStringList(_userKey, updatedExercises);

      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("An exercise added")));
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<List<ExercisesModel>> loadExercises() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingExeicises = pref.getStringList(_userKey);

    List<ExercisesModel> loadedExercises = [];
    if (existingExeicises != null) {
      loadedExercises = existingExeicises
          .map((e) => ExercisesModel.fromJson(jsonDecode(e)))
          .toList();
    }
    return loadedExercises;
  }
}
