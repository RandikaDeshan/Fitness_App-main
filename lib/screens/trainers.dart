import 'package:fitness_app/models/trainermodel.dart';
import 'package:fitness_app/services/trainerservice.dart';
import 'package:fitness_app/widgets/trainercard.dart';
import 'package:flutter/material.dart';

class TrainersPage extends StatefulWidget {
  const TrainersPage({super.key});

  @override
  State<TrainersPage> createState() => _TrainersPageState();
}

class _TrainersPageState extends State<TrainersPage> {
  List<TrainerModel> _users = [];
  List<TrainerModel> _filterdUsers = [];

  Future<void> _fetchAllMembers() async {
    try {
      final List<TrainerModel> users = await TrainerService().getAllUsers();
      setState(() {
        _users = users;
        _filterdUsers = users;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void _searchMembers(String query) {
    setState(() {
      _filterdUsers = _users
          .where(
            (user) => user.name.toLowerCase().contains(
                  query.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchAllMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
              const SizedBox(
                width: 60,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.search),
                          hintText: "Search",
                          border: UnderlineInputBorder(
                              borderSide: BorderSide.none)),
                      onChanged: _searchMembers,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filterdUsers.length,
                itemBuilder: (context, index) {
                  final trainer = _filterdUsers[index];

                  return Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: TrainerCard(
                          name: trainer.name,
                          password: trainer.password,
                          id: trainer.userId,
                          imageUrl: trainer.imageUrl,
                          gender: trainer.gender,
                          email: trainer.email,
                          age: trainer.age,
                          height: trainer.height,
                          weight: trainer.weight));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
