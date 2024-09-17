import 'package:fitness_app/services/auth/authservice.dart';
import 'package:fitness_app/wrapper/aorm.dart';
import 'package:fitness_app/wrapper/bottomnavbar.dart';

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool pass = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword() async {
    try {
      await AuthService().signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const AorMWrapper();
      }));
    } catch (e) {
      print('Error signing in with email and password: $e');
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Error signing in with email and password: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "Login Here",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Image.asset(
          "assets/gym1.png",
          width: 100,
        ),
        const SizedBox(
          height: 70,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter email';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      } else {
                        return null;
                      }
                    },
                    obscureText: pass,
                    decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              pass = !pass;
                            });
                          },
                          child: pass
                              ? const Icon(
                                  Icons.visibility,
                                )
                              : const Icon(Icons.visibility_off),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await _signInWithEmailAndPassword();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 5,
                          backgroundColor:
                              const Color.fromARGB(255, 54, 33, 243)),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ))
                ],
              )),
        )
      ],
    )));
  }
}
