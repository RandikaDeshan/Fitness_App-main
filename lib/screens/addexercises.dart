import 'dart:io';

import 'package:fitness_app/models/exercisesmodel.dart';
import 'package:fitness_app/services/exerciseserice.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddExercisesPage extends StatefulWidget {
  const AddExercisesPage({super.key});

  @override
  State<AddExercisesPage> createState() => _AddExercisesPageState();
}

class _AddExercisesPageState extends State<AddExercisesPage> {
  File? _selectedImage;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Future pickImageFromGallery() async {
    final imageUrl = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageUrl == null) return;
    setState(() {
      _selectedImage = File(imageUrl.path);
    });
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
                  _selectedImage != null
                      ? Image.file(
                          _selectedImage!,
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
                                    onPressed: () {
                                      pickImageFromGallery();
                                    },
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
                          List<ExercisesModel> loadedExercises =
                              await ExerciseService().loadExercises();

                          ExercisesModel exercise = ExercisesModel(
                              id: loadedExercises.length + 1,
                              name: _nameController.text,
                              imageUrl: _selectedImage!.path,
                              description: _descriptionController.text);

                          if (context.mounted) {
                            await ExerciseService()
                                .saveExercises(exercise, context);
                          }

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
