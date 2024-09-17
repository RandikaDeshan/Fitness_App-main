import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/models/gymmodel.dart';

class GymSevice {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection("gym");

  Future<void> saveGym() async {
    try {
      final GymModel gymOpen = GymModel(id: "", open: false);
      final DocumentReference docRef =
          await _collectionReference.add(gymOpen.toJson());
      await docRef.update({"id": docRef.id});
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateUser(GymModel gym) async {
    await _collectionReference.doc(gym.id).update(gym.toJson());
  }

  Future<GymModel?> getOpenById(String id) async {
    try {
      final doc = await _collectionReference.doc(id).get();
      if (doc.exists) {
        return GymModel.fromJson(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
