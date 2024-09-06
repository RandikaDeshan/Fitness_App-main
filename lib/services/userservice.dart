import 'dart:convert';

import 'package:fitness_app/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  // static Future<void> storeUserDetails(
  //     String name,
  //     String userId,
  //     String email,
  //     String password,
  //     String role,
  //     String age,
  //     String height,
  //     String weight,
  //     BuildContext context) async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setString("name", name);
  //     await prefs.setString("email", email);
  //     await prefs.setString("password", password);
  //     await prefs.setString("role", role);
  //     await prefs.setString("userId", userId);
  //     await prefs.setString("age", age);
  //     await prefs.setString("height", height);
  //     await prefs.setString("weight", weight);
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(const SnackBar(content: Text("A member added")));
  //     }
  //   } catch (error) {
  //     error.toString();
  //   }
  // }

  // static Future<bool> checkUsername() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String? name = pref.getString("name");
  //   return name != null;
  // }

  // static Future<bool> signInUser(String userName, String passWord) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String? username = pref.getString("email");
  //   String? password = pref.getString("password");
  //   if (userName == username) {
  //     if (passWord == password) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  List<UserModel> memberList = [];
  static const String _userKey = "users";

  Future<void> saveMembers(UserModel usermodel, BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? existingMembers = pref.getStringList(_userKey);

      List<UserModel> existingMemberObjects = [];

      if (existingMembers != null) {
        existingMemberObjects = existingMembers
            .map((e) => UserModel.fromJson(jsonDecode(e)))
            .toList();
      }

      existingMemberObjects.add(usermodel);

      List<String> updatedMembers =
          existingMemberObjects.map((e) => jsonEncode(e.toJson())).toList();

      await pref.setStringList(_userKey, updatedMembers);

      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("A member added")));
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<List<UserModel>> loadMembers() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingMembers = pref.getStringList(_userKey);

    List<UserModel> loadedMembers = [];
    if (existingMembers != null) {
      loadedMembers = existingMembers
          .map((e) => UserModel.fromJson(jsonDecode(e)))
          .toList();
    }
    return loadedMembers;
  }
}
