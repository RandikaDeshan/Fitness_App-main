import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/models/usermodel.dart';
import 'package:fitness_app/screens/home.dart';
import 'package:fitness_app/screens/members/homemember.dart';
import 'package:fitness_app/services/userservice.dart';
import 'package:fitness_app/wrapper/bottomnavbar.dart';
import 'package:flutter/material.dart';

class AorMWrapper extends StatefulWidget {
  const AorMWrapper({super.key});

  @override
  State<AorMWrapper> createState() => _AorMWrapperState();
}

class _AorMWrapperState extends State<AorMWrapper> {
  late Future<UserModel?> _getUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUser = getCurrentUser();
  }

  Future<UserModel?> getCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser!.uid;
    final userRole = await UserService().getUserById(user);
    return userRole;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUser,
      builder: (BuildContext context, snapshot) {
        final user = snapshot.data;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (user != null) {
          if (user.role == "user") {
            return HomeMember(
              name: user.name,
              password: user.password,
              userId: user.userId,
              imageUrl: user.imageUrl,
              gender: user.gender,
              email: user.email,
              age: user.age,
              height: user.height,
              weight: user.weight,
            );
          }
        }
        return const BottomNav();
      },
    );
  }
}
