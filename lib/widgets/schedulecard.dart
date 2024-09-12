import 'package:fitness_app/screens/schedulepage.dart';
import 'package:flutter/material.dart';

class ScheduleCard extends StatefulWidget {
  final String name;
  final String id;
  final String description;
  final String imageUrl;
  final int days;
  const ScheduleCard(
      {super.key,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.days,
      required this.id});

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
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
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SchedulePage(
                        name: widget.name,
                        id: widget.id,
                        description: widget.description,
                        imageUrl: widget.imageUrl,
                        days: widget.days);
                  }));
                },
                icon: const Icon(Icons.arrow_circle_right))
          ],
        ),
      ),
    );
  }
}
