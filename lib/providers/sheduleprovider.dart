import 'package:fitness_app/models/shedulemodel.dart';
import 'package:flutter/material.dart';

class SheduleProvider extends ChangeNotifier {
  List<SheduleModel> _allschedules = [];
  List<SheduleModel> schedules = [];

  SheduleProvider() {
    _allschedules = [
      SheduleModel(
          id: 1,
          name: "First",
          imageUrl: "",
          description: "description",
          list: [])
    ];
    schedules = List.from(_allschedules);
  }
}
