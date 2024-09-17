import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/models/usermodel.dart';
import 'package:fitness_app/services/auth/authservice.dart';
import 'package:fitness_app/services/userstorage.dart';

class UserService {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection("users");

  Future<void> saveUser(UserModel user) async {
    try {
      final userCredential = await AuthService().createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      final userId = userCredential!.user?.uid;

      if (userId != null) {
        final userRef = _usersCollection.doc(userId);
        final userMap = user.toJson();
        userMap['userId'] = userId;
        await userRef.set(userMap);
      }
    } catch (e) {
      print('Error creating user: $e');
    }
  }

  Future<UserModel?> getUserById(String userId) async {
    try {
      final doc = await _usersCollection.doc(userId).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      final snapshot = await _usersCollection.get();
      return snapshot.docs
          .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (error) {
      print('Error getting users: $error');
      return [];
    }
  }

  Future<void> deletePost(
      {required String userId, required String imageUrl}) async {
    try {
      await _usersCollection.doc(userId).delete();
      await UserProfileStorageService().deleteImage(imageUrl: imageUrl);
      print("Post deleted successfully");
    } catch (error) {
      print('Error deleting post: $error');
    }
  }

  Future<void> updateUser(UserModel user) async {
    await _usersCollection.doc(user.userId).update(user.toJson());
  }
}
