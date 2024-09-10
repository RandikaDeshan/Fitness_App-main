import 'package:fitness_app/screens/exercises.dart';
import 'package:fitness_app/screens/schedules.dart';
import 'package:fitness_app/services/auth/authservice.dart';
import 'package:fitness_app/widgets/exercisescard.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _inOut = false;
  bool _openClose = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          _inOut
                              ? Text(
                                  "In",
                                  style: TextStyle(color: Colors.blue[100]),
                                )
                              : const Text("Out"),
                          const SizedBox(
                            width: 8,
                          ),
                          Transform.scale(
                            scale: 0.7,
                            child: Switch(
                              activeColor: Colors.blue[100],
                              value: _inOut,
                              onChanged: (value) {
                                setState(() {
                                  _inOut = !_inOut;
                                });
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const Text(
                    "Fitness Center",
                    style: TextStyle(fontSize: 30),
                  ),
                  IconButton(
                      onPressed: AuthService().signOut,
                      icon: const Icon(Icons.person_outline_rounded))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset("assets/body2.jpg"),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Members : 100",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text("Trainers : 10", style: TextStyle(fontSize: 20))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _openClose
                      ? Text(
                          "Gym is open",
                          style:
                              TextStyle(fontSize: 25, color: Colors.blue[100]),
                        )
                      : const Text(
                          'Gym is close',
                          style: TextStyle(fontSize: 25),
                        ),
                  const SizedBox(
                    width: 20,
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      activeColor: Colors.blue[100],
                      value: _openClose,
                      onChanged: (value) {
                        setState(() {
                          _openClose = !_openClose;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 6,
                    child: ExercisesCard(
                      imageUrl: 'assets/gym6.png',
                      name: 'Exercises',
                      widget: ExercisesPage(),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: ExercisesCard(
                        imageUrl: "assets/gym7.png",
                        name: "Schedules",
                        widget: SchedulsPage()),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
