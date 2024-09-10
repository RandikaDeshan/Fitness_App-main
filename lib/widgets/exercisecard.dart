import 'package:fitness_app/screens/exercisepage.dart';
import 'package:flutter/material.dart';

class ExerciseCard extends StatefulWidget {
  final String name;
  final String description;
  final String imageUrl;
  const ExerciseCard(
      {super.key,
      required this.name,
      required this.description,
      required this.imageUrl});

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.imageUrl, scale: 1.0),
                fit: BoxFit.cover,
                opacity: 0.5),
            border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Colors.white,
                  blurRadius: 4,
                  spreadRadius: -1,
                  offset: Offset(0, 2))
            ]),
        child: Padding(
          padding: const EdgeInsets.only(left: 7),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.name,
                style: const TextStyle(
                    fontSize: 33,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.description,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ExercisePage();
                    }));
                  },
                  icon: const Icon(
                    Icons.arrow_circle_right,
                    color: Colors.blue,
                    size: 30,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
