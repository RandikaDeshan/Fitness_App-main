import 'package:fitness_app/models/exercisesmodel.dart';
import 'package:fitness_app/services/exerciseserice.dart';
import 'package:fitness_app/widgets/exercisecard.dart';
import 'package:flutter/material.dart';

class ExercisesPage extends StatefulWidget {
  
  const ExercisesPage({super.key, });

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  List<ExercisesModel> _exercises = [];
  List<ExercisesModel> _filterdExercises = [];

  Future<void> _fetchAllExercises() async {
    try {
      final List<ExercisesModel> exercises =
          await ExerciseService().getAllUsers();
      setState(() {
        _exercises = exercises;
        _filterdExercises = exercises;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void _searchExercises(String query) {
    setState(() {
      _filterdExercises = _exercises
          .where(
            (user) => user.name.toLowerCase().contains(
                  query.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchAllExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                      onChanged: _searchExercises,
                      decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.search),
                          hintText: "Search",
                          border: UnderlineInputBorder(
                              borderSide: BorderSide.none)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filterdExercises.length,
                itemBuilder: (context, index) {
                  final exercise = _filterdExercises[index];
                  return Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ExerciseCard(
                        
                        name: exercise.name,
                        id: exercise.id,
                        description: exercise.description,
                        imageUrl: exercise.imageUrl,
                        category: exercise.category,
                      ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
