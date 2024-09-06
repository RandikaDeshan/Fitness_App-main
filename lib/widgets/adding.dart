import 'package:flutter/material.dart';

class Adding extends StatefulWidget {
  final String name;
  final String imageUrl;
  final Widget page;
  const Adding(
      {super.key,
      required this.name,
      required this.imageUrl,
      required this.page});

  @override
  State<Adding> createState() => _AddingState();
}

class _AddingState extends State<Adding> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 500,
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
              opacity: 0.5,
              image: AssetImage(widget.imageUrl),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.name,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return widget.page;
                    },
                  ));
                },
                icon: const Icon(
                  Icons.add_box,
                  size: 50,
                ))
          ],
        ));
  }
}
