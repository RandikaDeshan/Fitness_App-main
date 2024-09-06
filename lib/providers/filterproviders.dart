import 'package:fitness_app/models/exercisesmodel.dart';
import 'package:fitness_app/models/shedulemodel.dart';
import 'package:fitness_app/models/usermodel.dart';
import 'package:fitness_app/providers/exerciseprovider.dart';
import 'package:fitness_app/providers/sheduleprovider.dart';
import 'package:fitness_app/providers/usersprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterProviders extends ChangeNotifier {
  List<dynamic> _allData = [];
  List<dynamic> filterdData = [];

  Future<void> getData(BuildContext context) async {
    await Future.delayed(Duration.zero);

    final List<UserModel> userModels =
        Provider.of<UsersProvider>(context, listen: false).users;
    final List<ExercisesModel> exercisesModel =
        Provider.of<ExerciseProvider>(context, listen: false).exercises;
    final List<SheduleModel> scheduleModel =
        Provider.of<SheduleProvider>(context, listen: false).schedules;

    _allData = [...userModels, ...exercisesModel, ...scheduleModel];
    filterdData = _allData;
    notifyListeners();
  }

  List<dynamic> get filteredData => filterdData;
}
