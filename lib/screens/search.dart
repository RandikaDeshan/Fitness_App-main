import 'package:fitness_app/screens/exercises.dart';
import 'package:fitness_app/screens/members.dart';
import 'package:fitness_app/screens/schedules.dart';
import 'package:fitness_app/screens/trainers.dart';
import 'package:fitness_app/widgets/exercisescard.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Searching Page",
                  style: TextStyle(fontSize: 30),
                ),
              )),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: ExercisesCard(
                        imageUrl: "assets/gym6.png",
                        name: 'Exercises',
                        widget: ExercisesPage()),
                  ),
                  Expanded(
                    flex: 6,
                    child: ExercisesCard(
                        imageUrl: "assets/gym7.png",
                        name: 'Schedules',
                        widget: SchedulsPage()),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  // Expanded(
                  //   flex: 6,
                  //   child: ExercisesCard(
                  //       imageUrl: "assets/gym4.png",
                  //       name: 'Members',
                  //       widget: MembersPage()),
                  // ),
                  Expanded(
                    flex: 6,
                    child: ExercisesCard(
                        imageUrl: "assets/gym5.png",
                        name: 'Trainers',
                        widget: TrainersPage()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
