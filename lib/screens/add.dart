import 'package:fitness_app/screens/addexercises.dart';
import 'package:fitness_app/screens/addmembers.dart';
import 'package:fitness_app/screens/addschedules.dart';
import 'package:fitness_app/screens/addtrainers.dart';
import 'package:fitness_app/widgets/adding.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text("Adding Page", style: TextStyle(fontSize: 30)),
              )),
              SizedBox(
                height: 30,
              ),
              Adding(
                name: 'Add Exercises',
                imageUrl: 'assets/body1.jpg',
                page: AddExercisesPage(),
              ),
              SizedBox(
                height: 20,
              ),
              Adding(
                name: 'Add Schedules',
                imageUrl: 'assets/body3.jpg',
                page: AddSchedules(),
              ),
              SizedBox(
                height: 20,
              ),
              Adding(
                name: 'Add Members',
                imageUrl: 'assets/body5.jpg',
                page: AddMembers(),
              ),
              SizedBox(
                height: 20,
              ),
              Adding(
                name: 'Add Trainers',
                imageUrl: 'assets/body4.jpg',
                page: AddTrainers(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
