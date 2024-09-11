import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/models/shedulemodel.dart';
import 'package:fitness_app/services/scheduleservice.dart';
import 'package:fitness_app/services/schedulestorage.dart';
import 'package:fitness_app/services/userservice.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddSchedules extends StatefulWidget {
  const AddSchedules({super.key});

  @override
  State<AddSchedules> createState() => _AddSchedulesState();
}

class _AddSchedulesState extends State<AddSchedules> {
  File? _imageFile;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _createSchedule() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final userDetails = await UserService().getUserById(user.uid);
        if (userDetails != null) {
          if (_imageFile != null) {
            final imageUrl = await ScheduleStorage()
                .uploadImage(exerciseImage: _imageFile, id: user.uid);
            _imageController.text = imageUrl;
          }
          await Scheduleservice().saveSchedules(SheduleModel(
              id: "",
              days: int.parse(_daysController.text),
              name: _nameController.text,
              imageUrl: _imageController.text,
              description: _descriptionController.text));
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Schedule created successfully'),
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
          title: const Center(child: Text("Add a new schedule")),
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
                          return 'Please enter a description';
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
                  TextFormField(
                      controller: _daysController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the no of days';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        hintText: "Days",
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
                          _createSchedule();
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
