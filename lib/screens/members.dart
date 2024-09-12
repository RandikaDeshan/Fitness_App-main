import 'package:fitness_app/models/usermodel.dart';
import 'package:fitness_app/services/userservice.dart';
import 'package:fitness_app/widgets/membercard.dart';
import 'package:flutter/material.dart';

class MembersPage extends StatefulWidget {
  const MembersPage({super.key});

  @override
  State<MembersPage> createState() => _MembersPageState();
}

final TextEditingController _searchController = TextEditingController();

class _MembersPageState extends State<MembersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: UserService().getMemberStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final List<UserModel> members = snapshot.data!;
          return Column(
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
                          controller: _searchController,
                          decoration: const InputDecoration(
                              hintText: "Search",
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.search))
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Flexible(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: members.length,
                    itemBuilder: (context, index) {
                      final member = members[index];

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
                          ));
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
