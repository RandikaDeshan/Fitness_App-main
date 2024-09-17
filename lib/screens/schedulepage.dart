import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/models/shedulemodel.dart';
import 'package:fitness_app/models/trainermodel.dart';
import 'package:fitness_app/models/usermodel.dart';
import 'package:fitness_app/services/scheduleservice.dart';
import 'package:fitness_app/services/schedulestorage.dart';
import 'package:fitness_app/services/trainerservice.dart';
import 'package:fitness_app/services/userservice.dart';
import 'package:fitness_app/wrapper/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SchedulePage extends StatefulWidget {
  final String name;
  final String id;
  final String description;
  final String imageUrl;
  final int days;
  const SchedulePage(
      {super.key,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.days,
      required this.id});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

Future<void> _deletePost(
    String postId, String postUrl, BuildContext context) async {
  try {
    await Scheduleservice().deletePost(
      id: postId,
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

class _SchedulePageState extends State<SchedulePage> {
  bool _isShow = false;
  File? _imageFile;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  Future<UserModel?> getCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser!.uid;
    final userRole = await UserService().getUserById(user);
    if (userRole?.role == "user") {
      setState(() {
        _isShow = false;
      });
    }
    return userRole;
  }

  Future<TrainerModel?> getCurrentTrainer() async {
    final user = FirebaseAuth.instance.currentUser!.uid;
    final userRole = await TrainerService().getUserById(user);
    if (userRole?.role != "user") {
      setState(() {
        _isShow = true;
      });
    }
    return userRole;
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void updateSchedule() async {
    try {
      final String name;
      final String description;
      final int days;
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userDetails = await TrainerService().getUserById(user.uid);
        if (userDetails != null) {
          if (_imageFile != null) {
            final imageUrl = await ScheduleStorage()
                .uploadImage(exerciseImage: _imageFile, id: user.uid);
            _imageController.text = imageUrl;
          } else {
            _imageController.text = widget.imageUrl;
          }
          if (_nameController.text == "") {
            name = widget.name;
          } else {
            name = _nameController.text;
          }
          if (_descriptionController.text == "") {
            description = widget.description;
          } else {
            description = _descriptionController.text;
          }
          if (_daysController.text == "") {
            days = widget.days;
          } else {
            days = int.parse(_daysController.text);
          }

          await Scheduleservice().updateSchedule(SheduleModel(
              id: widget.id,
              days: days,
              name: name,
              imageUrl: _imageController.text,
              description: description));
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Schedule updated successfully'),
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentTrainer();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.name)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              "${widget.days} Days Schedule",
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Image(
                image: NetworkImage(widget.imageUrl),
                width: 400,
                height: 280,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: Colors.blue.shade800,
                    border: Border.all(color: Colors.blue.shade100)),
                child: Column(
                  children: [
                    const Text(
                      "Guidelines",
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      widget.description,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            !_isShow
                ? const SizedBox(
                    width: 2,
                  )
                : SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
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
                                              TextFormField(
                                                  controller: _nameController,
                                                  decoration: InputDecoration(
                                                    border:
                                                        const OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5))),
                                                    hintText: widget.name,
                                                  )),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              TextFormField(
                                                  maxLines: 6,
                                                  controller:
                                                      _descriptionController,
                                                  decoration: InputDecoration(
                                                    border:
                                                        const OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5))),
                                                    hintText:
                                                        widget.description,
                                                  )),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              TextFormField(
                                                  controller: _daysController,
                                                  decoration: InputDecoration(
                                                    border:
                                                        const OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5))),
                                                    hintText:
                                                        widget.days.toString(),
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
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Text(
                                                            "Upload an image"),
                                                        const SizedBox(
                                                          width: 50,
                                                        ),
                                                        Container(
                                                            width: 45,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .blue
                                                                    .shade100,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            child: IconButton(
                                                                onPressed: () =>
                                                                    _pickImage(
                                                                        ImageSource
                                                                            .gallery),
                                                                icon:
                                                                    const Icon(
                                                                  Icons.upload,
                                                                  color: Colors
                                                                      .black,
                                                                )))
                                                      ],
                                                    ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    updateSchedule();
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                      builder: (context) {
                                                        return const BottomNav();
                                                      },
                                                    ));
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          elevation: 5,
                                                          backgroundColor:
                                                              const Color
                                                                  .fromARGB(255,
                                                                  54, 33, 243)),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
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
                          style: TextButton.styleFrom(
                              fixedSize: const Size(100, 10),
                              backgroundColor: Colors.grey.shade700),
                          label: const Text("Edit"),
                          icon: const Icon(
                            Icons.edit,
                            size: 17,
                          ),
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
                                          const Text("Delete this schedule"),
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
                                                    _deletePost(
                                                        widget.id,
                                                        widget.imageUrl,
                                                        context);

                                                    Navigator.pushReplacement(
                                                        context,
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
                    ))
          ],
        ),
      ),
    );
  }
}
