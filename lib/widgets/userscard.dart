import 'package:flutter/material.dart';

class UsersCard extends StatefulWidget {
  final String name;
  final int age;
  final double weight;
  final double height;
  final String role;
  const UsersCard(
      {super.key,
      required this.name,
      required this.age,
      required this.weight,
      required this.height,
      required this.role});

  @override
  State<UsersCard> createState() => _UsersCardState();
}

class _UsersCardState extends State<UsersCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue.shade200,
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
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    image: const DecorationImage(
                        image: NetworkImage(
                            "https://cdn-icons-png.freepik.com/512/18/18148.png"),
                        fit: BoxFit.cover)),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  // Row(
                  //   children: [
                  Text(
                    "Age : ${widget.age}",
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text("Weight : ${widget.weight}kg",
                      style: const TextStyle(color: Colors.black)),
                  const SizedBox(
                    width: 20,
                  ),
                  Text("Height ${widget.height}cm",
                      style: const TextStyle(color: Colors.black))
                  //   ],
                  // )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
