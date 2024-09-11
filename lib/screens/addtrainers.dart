import 'dart:io';

import 'package:fitness_app/models/trainermodel.dart';
import 'package:fitness_app/services/trainerservice.dart';
import 'package:fitness_app/services/trainerstorage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddTrainers extends StatefulWidget {
  const AddTrainers({super.key});

  @override
  State<AddTrainers> createState() => _AddTrainersState();
}

class _AddTrainersState extends State<AddTrainers> {
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

  Future<void> _createUser(BuildContext context) async {
    try {
      if (_imageFile != null) {
        final imageUrl = await TrainerStorage().uploadImage(
            profileImage: _imageFile, userEmail: _emailController.text);
        _imageController.text = imageUrl;
      } else {
        if (_genderController.text == "male") {
          _imageController.text = "https://i.stack.imgur.com/l60Hf.png";
        } else {
          _imageController.text =
              "https://thumb.ac-illust.com/30/30fa090868a2f8236c55ef8c1361db01_t.jpeg";
        }
      }
      if (gender != null) {
        _genderController.text = gender;
      }

      await TrainerService().saveTrainer(TrainerModel(
          userId: "",
          name: _nameController.text,
          password: _passwordController.text,
          role: "trainer",
          email: _emailController.text,
          age: int.parse(_ageController.text),
          height: double.parse(_heightController.text),
          gender: _genderController.text,
          weight: double.parse(_weightController.text),
          imageUrl: _imageController.text));

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Trainer created successfully'),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        AppBar(
          title: const Center(child: Text("Add a new trainer")),
        ),
        const SizedBox(
          height: 30,
        ),
        Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
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
                          : const CircleAvatar(
                              radius: 64,
                              backgroundImage: NetworkImage(
                                  'https://i.stack.imgur.com/l60Hf.png'),
                              backgroundColor: Colors.white,
                            ),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed: () => _pickImage(ImageSource.gallery),
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the name';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        hintText: "Name",
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a email';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        hintText: "Email",
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      controller: _heightController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the height';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        hintText: "Height",
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      controller: _weightController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the weight';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        hintText: "Weight",
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        label: const Text("Gender"),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade300))),
                    items: const [
                      DropdownMenuItem(
                        value: "male",
                        child: Text("male"),
                      ),
                      DropdownMenuItem(value: "female", child: Text("female")),
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter age';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        hintText: "Age",
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a password';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        hintText: "Password",
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await _createUser(context);
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 5,
                          backgroundColor:
                              const Color.fromARGB(255, 54, 33, 243)),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Add",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ))
                ],
              ),
            ))
      ],
    )));
  }
}
