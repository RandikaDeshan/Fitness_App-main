import 'package:flutter/material.dart';

class TrainerCard extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String gender;
  final String email;
  final int age;
  final double height;
  final double weight;
  const TrainerCard(
      {super.key,
      required this.name,
      required this.imageUrl,
      required this.gender,
      required this.email,
      required this.age,
      required this.height,
      required this.weight});

  @override
  State<TrainerCard> createState() => _TrainerCardState();
}

class _TrainerCardState extends State<TrainerCard> {
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
            CircleAvatar(
              backgroundImage: NetworkImage(widget.imageUrl),
            ),
            Text(
              widget.name,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            IconButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return
                  // }));
                },
                icon: const Icon(Icons.arrow_circle_right))
          ],
        ),
      ),
    );
  }
}
