import 'package:flutter/material.dart';

class ExercisePage extends StatefulWidget {
  final String name;
  final String description;
  final String imageUrl;
  final String category;
  const ExercisePage(
      {super.key,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.category});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.name)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text("${widget.category} Exercise"),
            Center(
              child: Image(
                image: NetworkImage(widget.imageUrl),
                width: 400,
                height: 280,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: Colors.blue.shade800,
                    border: Border.all(color: Colors.blue.shade100)),
                child: Column(
                  children: [
                    const Text(
                      "Guidelines",
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      widget.description,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () {},
            child: const Icon(Icons.edit),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () {},
            child: const Icon(Icons.delete),
          )
        ],
      ),
    );
  }
}
