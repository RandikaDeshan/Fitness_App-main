import 'package:flutter/material.dart';

class ExercisesCard extends StatefulWidget {
  final String imageUrl;
  final String name;
  final Widget widget;
  const ExercisesCard(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.widget});

  @override
  State<ExercisesCard> createState() => _ExercisesCardState();
}

class _ExercisesCardState extends State<ExercisesCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return widget.widget;
          },
        ));
      },
      child: SizedBox(
        height: 250,
        child: Card(
          color: Colors.blue[100],
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(fontSize: 24, color: Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  widget.imageUrl,
                  width: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
