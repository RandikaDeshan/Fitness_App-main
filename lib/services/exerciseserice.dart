import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/models/exercisesmodel.dart';

class ExerciseService {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection("exercises");

  Future<void> saveExercise(ExercisesModel exerciseDetails) async {
    try {
      final ExercisesModel exercise = ExercisesModel(
          id: "",
          name: exerciseDetails.name,
          imageUrl: exerciseDetails.imageUrl,
          description: exerciseDetails.description,
          userId: exerciseDetails.userId);
      final DocumentReference docRef =
          await _collectionReference.add(exercise.toJson());
      await docRef.update({"id": docRef.id});
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<List<ExercisesModel>> getExerciseStream() {
    return _collectionReference.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ExercisesModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
