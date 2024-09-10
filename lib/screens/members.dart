// import 'package:fitness_app/models/usermodel.dart';
// import 'package:fitness_app/services/userservice.dart';
// import 'package:fitness_app/widgets/userscard.dart';
// import 'package:flutter/material.dart';

// class MembersPage extends StatefulWidget {
//   const MembersPage({super.key});

//   @override
//   State<MembersPage> createState() => _MembersPageState();
// }

// class _MembersPageState extends State<MembersPage> {
//   List<UserModel> loadedMembers = [];
//   void fetchAllMembers() async {
//     List<UserModel> membersList = await UserService().loadMembers();
//     setState(() {
//       loadedMembers = membersList;
//     });
//   }

//   @override
//   void initState() {
//     fetchAllMembers();
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: const Icon(Icons.arrow_back)),
//               ],
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: loadedMembers.length,
//               itemBuilder: (context, index) {
//                 final member = loadedMembers[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(3.0),
//                   child: UsersCard(
//                       name: member.name,
//                       age: member.age,
//                       weight: member.weight,
//                       height: member.height,
//                       role: member.role),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
