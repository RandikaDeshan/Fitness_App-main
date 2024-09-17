import 'package:fitness_app/models/usermodel.dart';
import 'package:fitness_app/services/userservice.dart';
import 'package:fitness_app/widgets/membercard.dart';
import 'package:flutter/material.dart';

class MembersPage extends StatefulWidget {
  const MembersPage({super.key});

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  List<UserModel> _users = [];
  List<UserModel> _filterdUsers = [];

  Future<void> _fetchAllMembers() async {
    try {
      final List<UserModel> users = await UserService().getAllUsers();
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
                    child: TextField(
                      decoration: const InputDecoration(
                          hintText: "Search",
                          suffixIcon: Icon(Icons.search),
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
                  final member = _filterdUsers[index];

                  return Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: MemberCard(
                        name: member.name,
                        userId: member.userId,
                        imageUrl: member.imageUrl,
                        gender: member.gender,
                        email: member.email,
                        age: member.age,
                        height: member.height,
                        weight: member.weight,
                        password: member.password,
                      ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
