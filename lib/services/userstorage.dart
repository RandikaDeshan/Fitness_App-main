import 'package:firebase_storage/firebase_storage.dart';

class UserProfileStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(
      {required profileImage, required userEmail}) async {
    Reference ref = _storage
        .ref()
        .child("user-images")
        .child("$userEmail/${DateTime.now()}");

    try {
      UploadTask task = ref.putFile(
          profileImage, SettableMetadata(contentType: 'image/jpeg'));
      TaskSnapshot snapshot = await task;
      String downlodedUrl = await snapshot.ref.getDownloadURL();
      return downlodedUrl;
    } catch (e) {
      print(e);
      return "";
    }
  }
}
