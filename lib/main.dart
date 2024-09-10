import 'package:firebase_core/firebase_core.dart';

import 'package:fitness_app/wrapper/wrapper.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBDnBr_7AZ76yZCS-YutsY0qokXJqBVQHg",
          appId: "1:363592065762:android:7c06ce78485a73508ff4bb",
          messagingSenderId: "363592065762",
          projectId: "fitness-app-58b85"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: MaterialApp(
            theme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            title: 'Workout Planner',
            home: const WrapperPage()));
  }
}
