import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/screens/login.dart';
import 'package:fitness_app/wrapper/aorm.dart';
import 'package:flutter/material.dart';

class WrapperPage extends StatefulWidget {
  const WrapperPage({super.key});

  @override
  State<WrapperPage> createState() => _WrapperPageState();
}

class _WrapperPageState extends State<WrapperPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return const AorMWrapper();
        } else {
          return const Login();
        }
      },
    );
  }
}
