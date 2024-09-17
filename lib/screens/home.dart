import 'package:fitness_app/models/gymmodel.dart';
import 'package:fitness_app/models/trainermodel.dart';
import 'package:fitness_app/models/usermodel.dart';
import 'package:fitness_app/screens/exercises.dart';
import 'package:fitness_app/screens/login.dart';
import 'package:fitness_app/screens/schedules.dart';
import 'package:fitness_app/services/auth/authservice.dart';
import 'package:fitness_app/services/gymservice.dart';
import 'package:fitness_app/services/trainerservice.dart';
import 'package:fitness_app/services/userservice.dart';
import 'package:fitness_app/widgets/exercisescard.dart';
import 'package:fitness_app/wrapper/wrapper.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<UserModel> users = [];
  List<TrainerModel> trainers = [];
  bool _inOut = false;
  bool _openClose = false;

  Future<void> _fetchAllUsers() async {
    try {
      final List<UserModel> members = await UserService().getAllUsers();
      setState(() {
        users = members;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _fetchAllTrainers() async {
    try {
      final List<TrainerModel> members = await TrainerService().getAllUsers();
      setState(() {
        trainers = members;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getOpen() async {
    final gym = await GymSevice().getOpenById("KFxARBsYd8yZ7SiSvOzx");
    if (gym!.open) {
      setState(() {
        _openClose = true;
      });
    } else {
      setState(() {
        _openClose = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchAllUsers();
    _fetchAllTrainers();
    getOpen();
  }

  void updateOpen() async {
    setState(() {
      _openClose = !_openClose;
    });
    if (_openClose) {
      await GymSevice()
          .updateUser(GymModel(open: true, id: 'KFxARBsYd8yZ7SiSvOzx'));
    } else {
      await GymSevice()
          .updateUser(GymModel(open: false, id: 'KFxARBsYd8yZ7SiSvOzx'));
    }
  }

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
                      icon: const Icon(Icons.logout))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset("assets/body2.jpg"),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Members : ${users.length}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text("Trainers : ${trainers.length}",
                      style: const TextStyle(fontSize: 20))
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
                        updateOpen();
                      },
                    ),
                  )
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
