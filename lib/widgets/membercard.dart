import 'package:fitness_app/screens/memberpage.dart';
import 'package:flutter/material.dart';

class MemberCard extends StatefulWidget {
  final String name;
  final String password;
  final String userId;
  final String imageUrl;
  final String gender;
  final String email;
  final int age;
  final double height;
  final double weight;
  const MemberCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.gender,
    required this.email,
    required this.age,
    required this.height,
    required this.weight,
    required this.userId,
    required this.password,
  });

  @override
  State<MemberCard> createState() => _MemberCardState();
}

class _MemberCardState extends State<MemberCard> {
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MemberPage(
                        name: widget.name,
                        password: widget.password,
                        userId: widget.userId,
                        imageUrl: widget.imageUrl,
                        gender: widget.gender,
                        email: widget.email,
                        age: widget.age,
                        height: widget.height,
                        weight: widget.weight);
                  }));
                },
                icon: const Icon(Icons.arrow_circle_right))
          ],
        ),
      ),
    );
  }
}
