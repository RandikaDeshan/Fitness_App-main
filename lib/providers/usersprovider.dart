import 'package:fitness_app/models/usermodel.dart';
import 'package:flutter/material.dart';

class UsersProvider extends ChangeNotifier {
  List<UserModel> allUsers = [];
  List<UserModel> users = [];

  UsersProvider() {
    allUsers = [
      UserModel(
          userId: '1',
          name: "Randika",
          password: "111111",
          role: "Admin",
          email: "randika@gmail.com",
          gender: "male",
          age: 25,
          height: 150,
          weight: 90,
          imageUrl: ""),
      UserModel(
          userId: '2',
          name: "Deshan",
          password: "222222",
          role: "User",
          email: "deshan@gmail.com",
          gender: "male",
          age: 25,
          height: 150,
          weight: 90,
          imageUrl: ""),
    ];
    // users = List.from(_allUsers);
    notifyListeners();
  }
}
