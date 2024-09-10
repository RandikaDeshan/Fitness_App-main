import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/models/exercisesmodel.dart';
import 'package:fitness_app/services/exerciesstorage.dart';
import 'package:fitness_app/services/exerciseserice.dart';
import 'package:fitness_app/services/userservice.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddExercisesPage extends StatefulWidget {
  const AddExercisesPage({super.key});

  @override
  State<AddExercisesPage> createState() => _AddExercisesPageState();
}

class _AddExercisesPageState extends State<AddExercisesPage> {
  File? _imageFile;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _createExercise() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final userDetails = await UserService().getUserById(user.uid);
        if (userDetails != null) {
          if (_imageFile != null) {
            final imageUrl = await ExerciesStorage()
                .uploadImage(exerciseImage: _imageFile, id: user.uid);
            _imageController.text = imageUrl;
          }

          await ExerciseService().saveExercise(ExercisesModel(
              id: "",
              name: _nameController.text,
              imageUrl: _imageController.text,
              description: _descriptionController.text,
              userId: user.uid));
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Exercise created successfully'),
              ),
            );
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        AppBar(
          title: const Center(child: Text("Add an new exercise")),
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
                      maxLines: 6,
                      controller: _descriptionController,
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
                        hintText: "Description",
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  _imageFile != null
                      ? Image.file(
                          _imageFile!,
                          width: 300,
                          height: 250,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Upload an image"),
                            const SizedBox(
                              width: 50,
                            ),
                            Container(
                                width: 45,
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade100,
                                    borderRadius: BorderRadius.circular(5)),
                                child: IconButton(
                                    onPressed: () =>
                                        _pickImage(ImageSource.gallery),
                                    icon: const Icon(
                                      Icons.upload,
                                      color: Colors.black,
                                    )))
                          ],
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _createExercise();
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
