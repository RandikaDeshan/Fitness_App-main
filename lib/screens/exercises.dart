import 'package:fitness_app/models/exercisesmodel.dart';
import 'package:fitness_app/services/exerciseserice.dart';
import 'package:fitness_app/widgets/exercisecard.dart';
import 'package:flutter/material.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

final TextEditingController _searchController = TextEditingController();

class _ExercisesPageState extends State<ExercisesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: ExerciseService().getExerciseStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final List<ExercisesModel> exercises = snapshot.data!;

            return Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back)),
                    const SizedBox(
                      width: 60,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                                hintText: "Search",
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none)),
                          ),
                        ),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.search))
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Flexible(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: exercises.length,
                      itemBuilder: (context, index) {
                        final exercise = exercises[index];
                        return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ExerciseCard(
                              name: exercise.name,
                              description: exercise.description,
                              imageUrl: exercise.imageUrl,
                              category: exercise.category,
                            ));
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
