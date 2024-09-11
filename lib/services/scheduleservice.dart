import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/models/shedulemodel.dart';

class Scheduleservice {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection("schedules");

  Future<void> saveSchedules(SheduleModel scheduleDetails) async {
    try {
      final SheduleModel schedule = SheduleModel(
          id: "",
          days: scheduleDetails.days,
          name: scheduleDetails.name,
          imageUrl: scheduleDetails.imageUrl,
          description: scheduleDetails.description);
      final DocumentReference docRef =
          await _collectionReference.add(schedule.toJson());
      await docRef.update({"id": docRef.id});
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<List<SheduleModel>> getScheduleStream() {
    return _collectionReference.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return SheduleModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
