import 'package:fitness_app/models/shedulemodel.dart';
import 'package:fitness_app/services/scheduleservice.dart';
import 'package:fitness_app/widgets/schedulecard.dart';
import 'package:flutter/material.dart';

class SchedulsPage extends StatefulWidget {
  const SchedulsPage({super.key});

  @override
  State<SchedulsPage> createState() => _SchedulsPageState();
}

class _SchedulsPageState extends State<SchedulsPage> {
  List<SheduleModel> _schedules = [];
  List<SheduleModel> _filterdSchedules = [];

  Future<void> _fetchAllSchedules() async {
    try {
      final List<SheduleModel> shedules = await Scheduleservice().getAllUsers();
      setState(() {
        _schedules = shedules;
        _filterdSchedules = shedules;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void _searchSchedules(String query) {
    setState(() {
      _filterdSchedules = _schedules
          .where(
            (user) => user.name.toLowerCase().contains(
                  query.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchAllSchedules();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
              const SizedBox(
                width: 60,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      onChanged: _searchSchedules,
                      decoration: const InputDecoration(
                          hintText: "Search",
                          suffixIcon: Icon(Icons.search),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide.none)),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search))
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filterdSchedules.length,
                itemBuilder: (context, index) {
                  final schedule = _filterdSchedules[index];
                  return Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ScheduleCard(
                        name: schedule.name,
                        id: schedule.id,
                        description: schedule.description,
                        imageUrl: schedule.imageUrl,
                        days: schedule.days,
                      ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
