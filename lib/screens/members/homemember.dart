import 'dart:io';

import 'package:fitness_app/models/trainermodel.dart';
import 'package:fitness_app/models/usermodel.dart';
import 'package:fitness_app/screens/exercises.dart';
import 'package:fitness_app/screens/schedules.dart';
import 'package:fitness_app/services/auth/authservice.dart';
import 'package:fitness_app/services/gymservice.dart';
import 'package:fitness_app/services/trainerservice.dart';
import 'package:fitness_app/services/userservice.dart';
import 'package:fitness_app/services/userstorage.dart';
import 'package:fitness_app/widgets/exercisescard.dart';
import 'package:fitness_app/wrapper/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeMember extends StatefulWidget {
  final String name;
  final String password;
  final String userId;
  final String imageUrl;
  final String gender;
  final String email;
  final int age;
  final double height;
  final double weight;
  const HomeMember(
      {super.key,
      required this.name,
      required this.password,
      required this.userId,
      required this.imageUrl,
      required this.gender,
      required this.email,
      required this.age,
      required this.height,
      required this.weight});

  @override
  State<HomeMember> createState() => _HomeMemberState();
}

class _HomeMemberState extends State<HomeMember> {
  List<UserModel> users = [];
  List<TrainerModel> trainers = [];
  bool _inOut = false;
  bool _openClose = false;

  final _formKey = GlobalKey<FormState>();
  String gender = "";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  File? _imageFile;
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void updateMember() async {
    try {
      final String name;
      final String password;
      final String _gender;
      final String email;
      final int age;
      final double height;
      final double weight;
      if (gender != null) {
        _genderController.text = gender;
      }
      if (_imageFile != null) {
        final imageUrl = await UserProfileStorageService().uploadImage(
            profileImage: _imageFile, userEmail: _emailController.text);
        _imageController.text = imageUrl;
      } else {
        _imageController.text = widget.imageUrl;
      }
      if (_nameController.text == "") {
        name = widget.name;
      } else {
        name = _nameController.text;
      }
      if (_emailController.text == "") {
        email = widget.email;
      } else {
        email = _emailController.text;
      }
      if (_passwordController.text == "") {
        password = widget.password;
      } else {
        password = _passwordController.text;
      }
      if (_genderController.text == "") {
        _gender = widget.name;
      } else {
        _gender = _genderController.text;
      }
      if (_ageController.text == "") {
        age = widget.age;
      } else {
        age = int.parse(_ageController.text);
      }
      if (_heightController.text == "") {
        height = widget.height;
      } else {
        height = double.parse(_heightController.text);
      }
      if (_weightController.text == "") {
        weight = widget.weight;
      } else {
        weight = double.parse(_weightController.text);
      }

      await UserService().updateUser(UserModel(
          userId: widget.userId,
          name: name,
          password: password,
          role: "user",
          email: email,
          age: age,
          height: height,
          gender: _gender,
          weight: weight,
          imageUrl: _imageController.text));
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return HomeMember(
              name: name,
              password: password,
              userId: widget.userId,
              imageUrl: _imageController.text,
              gender: _gender,
              email: email,
              age: age,
              height: height,
              weight: weight);
        },
      ));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Member Details updated successfully'),
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _fetchAllUsers() async {
    try {
      final List<UserModel> members = await UserService().getAllUsers();
      setState(() {
        users = members;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _fetchAllTrainers() async {
    try {
      final List<TrainerModel> members = await TrainerService().getAllUsers();
      setState(() {
        trainers = members;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getOpen() async {
    final gym = await GymSevice().getOpenById("KFxARBsYd8yZ7SiSvOzx");
    if (gym!.open) {
      setState(() {
        _openClose = true;
      });
    } else {
      setState(() {
        _openClose = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchAllUsers();
    _fetchAllTrainers();
    getOpen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          _inOut
                              ? Text(
                                  "In",
                                  style: TextStyle(color: Colors.blue[100]),
                                )
                              : const Text("Out"),
                          const SizedBox(
                            width: 8,
                          ),
                          Transform.scale(
                            scale: 0.7,
                            child: Switch(
                              activeColor: Colors.blue[100],
                              value: _inOut,
                              onChanged: (value) {
                                setState(() {
                                  _inOut = !_inOut;
                                });
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const Text(
                    "Fitness Center",
                    style: TextStyle(fontSize: 30),
                  ),
                  IconButton(
                      onPressed: AuthService().signOut,
                      icon: const Icon(Icons.logout))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset("assets/body2.jpg"),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _openClose
                      ? Text(
                          "Gym is open",
                          style:
                              TextStyle(fontSize: 25, color: Colors.blue[100]),
                        )
                      : const Text(
                          'Gym is close',
                          style: TextStyle(fontSize: 25),
                        ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 6,
                    child: ExercisesCard(
                      imageUrl: 'assets/gym6.png',
                      name: 'Exercises',
                      widget: ExercisesPage(),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: ExercisesCard(
                        imageUrl: "assets/gym7.png",
                        name: "Schedules",
                        widget: SchedulsPage()),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(widget.imageUrl),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.email,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Gender : ${widget.gender}",
                                  style: const TextStyle(fontSize: 17),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  " Age :${widget.age.toString()}",
                                  style: const TextStyle(fontSize: 17),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Height : ${widget.height.toString()}cm",
                                  style: const TextStyle(fontSize: 17),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Weight : ${widget.weight.toString()}Kg",
                                  style: const TextStyle(fontSize: 17),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                _imageFile != null
                                    ? CircleAvatar(
                                        radius: 64,
                                        backgroundImage: FileImage(_imageFile!),
                                        backgroundColor: Colors.white,
                                      )
                                    : CircleAvatar(
                                        radius: 64,
                                        backgroundImage:
                                            NetworkImage(widget.imageUrl),
                                        backgroundColor: Colors.white,
                                      ),
                                Positioned(
                                  bottom: -10,
                                  left: 80,
                                  child: IconButton(
                                    onPressed: () =>
                                        _pickImage(ImageSource.gallery),
                                    icon: const Icon(Icons.add_a_photo),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  hintText: widget.name,
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  hintText: widget.email,
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                                controller: _heightController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  hintText: widget.height.toString(),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                                controller: _weightController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  hintText: widget.weight.toString(),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                  label: Text(widget.gender),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300))),
                              items: const [
                                DropdownMenuItem(
                                  value: "male",
                                  child: Text("male"),
                                ),
                                DropdownMenuItem(
                                    value: "female", child: Text("female")),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  gender = value!;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                                controller: _ageController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  hintText: widget.age.toString(),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  hintText: widget.password,
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  updateMember();
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 5,
                                    backgroundColor:
                                        const Color.fromARGB(255, 54, 33, 243)),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    "Update",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    )),
              );
            },
          );
        },
        child: const Icon(Icons.settings),
      ),
    );
  }
}
