import 'dart:io';

import 'package:fitness_app/models/usermodel.dart';
import 'package:fitness_app/services/userservice.dart';
import 'package:fitness_app/services/userstorage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddMembers extends StatefulWidget {
  const AddMembers({
    super.key,
  });

  @override
  State<AddMembers> createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
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
        final imageUrl = await UserProfileStorageService().uploadImage(
            profileImage: _imageFile, userEmail: _emailController.text);
        _imageController.text = imageUrl;
      }

      await UserService().saveUser(UserModel(
          userId: "",
          name: _nameController.text,
          password: _passwordController.text,
          role: "user",
          email: _emailController.text,
          age: int.parse(_ageController.text),
          height: double.parse(_heightController.text),
          gender: _genderController.text,
          weight: double.parse(_weightController.text),
          imageUrl: _imageController.text));

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User created successfully'),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _ageController.dispose();
    _passwordController.dispose();
    _roleController.dispose();

    _genderController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        AppBar(
          title: const Center(child: Text("Add a new member")),
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
                  TextFormField(
                      controller: _genderController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter gender';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        hintText: "Gender",
                      )),
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
                          // List<UserModel> loadedMembers =
                          //     await UserService().loadMembers();

                          // UserModel user = UserModel(
                          //     userId: loadedMembers.length + 1,
                          //     name: _nameController.text,
                          //     password: _passwordController.text,
                          //     role: "User",
                          //     email: _emailController.text,
                          //     age: int.parse(_ageController.text),
                          //     height: double.parse(_heightController.text),
                          //     gender: _genderController.text,
                          //     weight: double.parse(_weightController.text));

                          // if (context.mounted) {
                          //   await UserService().saveMembers(user, context);
                          // }
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
