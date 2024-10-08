import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/models/trainermodel.dart';
import 'package:fitness_app/services/auth/authservice.dart';
import 'package:fitness_app/services/trainerstorage.dart';

class TrainerService {
  final CollectionReference _trainerCollection =
      FirebaseFirestore.instance.collection("trainers");

  Future<void> saveTrainer(TrainerModel trainer) async {
    try {
      final userCredential = await AuthService().createUserWithEmailAndPassword(
          email: trainer.email, password: trainer.password);

      final trainerId = userCredential!.user?.uid;

      if (trainerId != null) {
        final userRef = _trainerCollection.doc(trainerId);
        final userMap = trainer.toJson();
        userMap["userId"] = trainerId;

        await userRef.set(userMap);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<TrainerModel?> getUserById(String userId) async {
    try {
      final doc = await _trainerCollection.doc(userId).get();
      if (doc.exists) {
        return TrainerModel.fromJson(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<List<TrainerModel>> getAllUsers() async {
    try {
      final snapshot = await _trainerCollection.get();
      return snapshot.docs
          .map((doc) =>
              TrainerModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (error) {
      print('Error getting users: $error');
      return [];
    }
  }

  Future<void> deletePost(
      {required String userId, required String imageUrl}) async {
    try {
      await _trainerCollection.doc(userId).delete();
      await TrainerStorage().deleteImage(imageUrl: imageUrl);
      print("Post deleted successfully");
    } catch (error) {
      print('Error deleting post: $error');
    }
  }

  Future<void> updateTriner(TrainerModel trainer) async {
    await _trainerCollection.doc(trainer.userId).update(trainer.toJson());
  }
}
