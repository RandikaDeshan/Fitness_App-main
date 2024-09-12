import 'package:fitness_app/screens/exercisepage.dart';
import 'package:flutter/material.dart';

class ExerciseCard extends StatefulWidget {
  final String name;
  final String id;
  final String description;
  final String imageUrl;
  final String category;
  const ExerciseCard(
      {super.key,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.category,
      required this.id});

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.grey.shade800),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.name,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text("${widget.category} Exercise"),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return OneExercisePage(
                      name: widget.name,
                      id: widget.id,
                      description: widget.description,
                      imageUrl: widget.imageUrl,
                      category: widget.category,
                    );
                  }));
                },
                icon: const Icon(Icons.arrow_circle_right))
          ],
        ),
      ),
    );
  }
}
