import 'package:fitness_app/screens/login.dart';
import 'package:fitness_app/wrapper/bottomnavbar.dart';
import 'package:flutter/material.dart';

class WrapperPage extends StatefulWidget {
  final bool showMainScreen;
  const WrapperPage({super.key, required this.showMainScreen});

  @override
  State<WrapperPage> createState() => _WrapperPageState();
}

class _WrapperPageState extends State<WrapperPage> {
  @override
  Widget build(BuildContext context) {
    return widget.showMainScreen ? const BottomNav() : const Login();
  }
}
