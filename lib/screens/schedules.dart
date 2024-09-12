import 'package:fitness_app/models/shedulemodel.dart';
import 'package:fitness_app/services/scheduleservice.dart';
import 'package:fitness_app/widgets/schedulecard.dart';
import 'package:flutter/material.dart';

class SchedulsPage extends StatefulWidget {
  const SchedulsPage({super.key});

  @override
  State<SchedulsPage> createState() => _SchedulsPageState();
}

final TextEditingController _searchController = TextEditingController();

class _SchedulsPageState extends State<SchedulsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Scheduleservice().getSchedulesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List<SheduleModel> schedules = snapshot.data!;

          return Column(
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
                          controller: _searchController,
                          decoration: const InputDecoration(
                              hintText: "Search",
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.search))
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Flexible(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: schedules.length,
                    itemBuilder: (context, index) {
                      final schedule = schedules[index];
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
          );
        },
      ),
    );
  }
}
