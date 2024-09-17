import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/models/shedulemodel.dart';
import 'package:fitness_app/services/schedulestorage.dart';

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

  Future<List<SheduleModel>> getAllUsers() async {
    try {
      final snapshot = await _collectionReference.get();
      return snapshot.docs
          .map((doc) =>
              SheduleModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (error) {
      print('Error getting users: $error');
      return [];
    }
  }

  Future<void> deletePost(
      {required String id, required String imageUrl}) async {
    try {
      await _collectionReference.doc(id).delete();
      await ScheduleStorage().deleteImage(imageUrl: imageUrl);
      print("Post deleted successfully");
    } catch (error) {
      print('Error deleting post: $error');
    }
  }

  Future<void> updateSchedule(SheduleModel schedule) async {
    await _collectionReference.doc(schedule.id).update(schedule.toJson());
  }
}
