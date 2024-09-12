import 'package:fitness_app/services/scheduleservice.dart';
import 'package:fitness_app/wrapper/bottomnavbar.dart';
import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  final String name;
  final String id;
  final String description;
  final String imageUrl;
  final int days;
  const SchedulePage(
      {super.key,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.days,
      required this.id});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

Future<void> _deletePost(
    String postId, String postUrl, BuildContext context) async {
  try {
    await Scheduleservice().deletePost(
      id: postId,
      imageUrl: postUrl,
    );

    //show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Post deleted successfully'),
      ),
    );
  } catch (e) {
    print('Error deleting post: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error deleting post'),
      ),
    );
  }
}

class _SchedulePageState extends State<SchedulePage> {
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
              Text(
                "${widget.days} Days Schedule",
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(
                height: 30,
              ),
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: SizedBox(
                    height: 100,
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Delete this member"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel")),
                              TextButton(
                                  onPressed: () async {
                                    await _deletePost(
                                        widget.id, widget.imageUrl, context);

                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                      builder: (context) {
                                        return const BottomNav();
                                      },
                                    ));
                                  },
                                  child: const Text("Ok"))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: const Icon(Icons.delete),
        ));
  }
}
