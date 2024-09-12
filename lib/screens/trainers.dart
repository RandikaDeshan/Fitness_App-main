import 'package:fitness_app/models/trainermodel.dart';
import 'package:fitness_app/services/trainerservice.dart';
import 'package:fitness_app/widgets/trainercard.dart';
import 'package:flutter/material.dart';

class TrainersPage extends StatefulWidget {
  const TrainersPage({super.key});

  @override
  State<TrainersPage> createState() => _TrainersPageState();
}

final TextEditingController _searchController = TextEditingController();

class _TrainersPageState extends State<TrainersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: TrainerService().getTrainersStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final List<TrainerModel> trainers = snapshot.data!;
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
                    itemCount: trainers.length,
                    itemBuilder: (context, index) {
                      final trainer = trainers[index];

                      return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: TrainerCard(
                              name: trainer.name,
                              id: trainer.userId,
                              imageUrl: trainer.imageUrl,
                              gender: trainer.gender,
                              email: trainer.email,
                              age: trainer.age,
                              height: trainer.height,
                              weight: trainer.weight));
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
