import 'package:fitness_app/models/exercisesmodel.dart';
import 'package:fitness_app/services/exerciseserice.dart';
import 'package:fitness_app/widgets/exercisecard.dart';
import 'package:flutter/material.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  List<ExercisesModel> loadedExercises = [];
  void fetchAllExercises() async {
    List<ExercisesModel> exercisesList =
        await ExerciseService().loadExercises();
    setState(() {
      loadedExercises = exercisesList;
    });
  }

  @override
  void initState() {
    fetchAllExercises();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: loadedExercises.length,
              itemBuilder: (context, index) {
                final exercise = loadedExercises[index];
                return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ExerciseCard(
                        name: exercise.name,
                        description: exercise.description,
                        imageUrl: exercise.imageUrl));
              },
            ),
          ],
        ),
      ),
    );
  }
}
