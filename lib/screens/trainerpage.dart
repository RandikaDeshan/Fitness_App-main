import 'dart:io';

import 'package:fitness_app/models/trainermodel.dart';
import 'package:fitness_app/services/trainerservice.dart';
import 'package:fitness_app/services/trainerstorage.dart';
import 'package:fitness_app/wrapper/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TrainerPade extends StatefulWidget {
  final String name;
  final String password;
  final String id;
  final String imageUrl;
  final String gender;
  final String email;
  final int age;
  final double height;
  final double weight;
  const TrainerPade(
      {super.key,
      required this.name,
      required this.imageUrl,
      required this.gender,
      required this.email,
      required this.age,
      required this.height,
      required this.weight,
      required this.id,
      required this.password});

  @override
  State<TrainerPade> createState() => _TrainerPadeState();
}

Future<void> _deletePost(
    String postId, String postUrl, BuildContext context) async {
  try {
    await TrainerService().deletePost(
      userId: postId,
      imageUrl: postUrl,
    );

    //show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Post deleted successfully'),
      ),
    );
  } catch (e) {
    print('Error deleting post: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error deleting post'),
      ),
    );
  }
}

class _TrainerPadeState extends State<TrainerPade> {
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

  void updateTrainer() async {
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
        final imageUrl = await TrainerStorage().uploadImage(
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

      await TrainerService().updateTriner(TrainerModel(
          userId: widget.id,
          name: name,
          password: password,
          role: "trainer",
          email: email,
          age: age,
          height: height,
          gender: _gender,
          weight: weight,
          imageUrl: _imageController.text));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Trainer Details updated successfully'),
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.name)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(widget.imageUrl),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
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
            ),
            SizedBox(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        fixedSize: const Size(100, 10),
                        backgroundColor: Colors.grey.shade700),
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
                                                    backgroundImage:
                                                        FileImage(_imageFile!),
                                                    backgroundColor:
                                                        Colors.white,
                                                  )
                                                : CircleAvatar(
                                                    radius: 64,
                                                    backgroundImage:
                                                        NetworkImage(
                                                            widget.imageUrl),
                                                    backgroundColor:
                                                        Colors.white,
                                                  ),
                                            Positioned(
                                              bottom: -10,
                                              left: 80,
                                              child: IconButton(
                                                onPressed: () => _pickImage(
                                                    ImageSource.gallery),
                                                icon: const Icon(
                                                    Icons.add_a_photo),
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
                                                      BorderRadius.all(
                                                          Radius.circular(5))),
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
                                                      BorderRadius.all(
                                                          Radius.circular(5))),
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
                                                      BorderRadius.all(
                                                          Radius.circular(5))),
                                              hintText:
                                                  widget.height.toString(),
                                            )),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                            controller: _weightController,
                                            decoration: InputDecoration(
                                              border: const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5))),
                                              hintText:
                                                  widget.weight.toString(),
                                            )),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        DropdownButtonFormField(
                                          decoration: InputDecoration(
                                              label: Text(widget.gender),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors
                                                          .grey.shade300))),
                                          items: const [
                                            DropdownMenuItem(
                                              value: "male",
                                              child: Text("male"),
                                            ),
                                            DropdownMenuItem(
                                                value: "female",
                                                child: Text("female")),
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
                                                      BorderRadius.all(
                                                          Radius.circular(5))),
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
                                                      BorderRadius.all(
                                                          Radius.circular(5))),
                                              hintText: widget.password,
                                            )),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(
                                            onPressed: () async {
                                              updateTrainer();
                                              if (context.mounted) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                  builder: (context) {
                                                    return const BottomNav();
                                                  },
                                                ));
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                elevation: 5,
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 54, 33, 243)),
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: Text(
                                                "Update",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
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
                    label: const Text("Edit"),
                    icon: const Icon(Icons.edit),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        fixedSize: const Size(100, 10),
                        backgroundColor: Colors.grey.shade700),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: SizedBox(
                              height: 100,
                              width: 150,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Delete this trainer"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cancel")),
                                        TextButton(
                                            onPressed: () async {
                                              _deletePost(widget.id,
                                                  widget.imageUrl, context);

                                              Navigator.pushReplacement(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return const BottomNav();
                                                },
                                              ));
                                            },
                                            child: const Text("Ok"))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    label: const Text('Delete'),
                    icon: const Icon(
                      Icons.delete,
                      size: 17,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
