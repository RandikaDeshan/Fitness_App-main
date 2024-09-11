import 'package:firebase_storage/firebase_storage.dart';

class ScheduleStorage {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage({required exerciseImage, required id}) async {
    final Reference ref =
        _storage.ref().child("schedule-images").child("$id/${DateTime.now()}");
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
}
