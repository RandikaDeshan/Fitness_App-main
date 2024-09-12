import 'package:firebase_storage/firebase_storage.dart';

class ExerciesStorage {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage({required exerciseImage, required id}) async {
    final Reference ref =
        _storage.ref().child("exercise-images").child("$id/${DateTime.now()}");
    try {
      final UploadTask task = ref.putFile(exerciseImage);

      TaskSnapshot snapshot = await task;
      String url = await snapshot.ref.getDownloadURL();

      return url;
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  Future<void> deleteImage({required String imageUrl}) async {
    try {
      await _storage.refFromURL(imageUrl).delete();
    } catch (e) {
      print(e);
    }
  }
}
