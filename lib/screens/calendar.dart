import 'package:fitness_app/services/gymservice.dart';
import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  bool _openClose = false;
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
    getOpen();
  }

  @override
  Widget build(BuildContext context) {
    return _openClose ? const Text("Open") : const Text("Close");
  }
}
