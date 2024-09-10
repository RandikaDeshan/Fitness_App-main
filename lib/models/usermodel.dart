class UserModel {
  final String userId;
  final String name;
  final String password;
  final String role;
  final String email;
  final String gender;
  final int age;
  final double height;
  final double weight;
  final String? imageUrl;
  final DateTime? createdAt;

  UserModel(
      {required this.userId,
      required this.name,
      required this.password,
      required this.role,
      required this.email,
      this.createdAt,
      required this.age,
      required this.height,
      required this.gender,
      required this.weight,
      this.imageUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userId: json["userId"],
        name: json["name"],
        password: json["password"],
        role: json["role"],
        email: json["email"],
        createdAt: json["createdAt"],
        age: json["age"],
        height: json["height"],
        gender: json["gender"],
        weight: json["weight"],
        imageUrl: json["imageUrl"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "name": name,
      "password": password,
      "role": role,
      "email": email,
      "createdAt": createdAt,
      "age": age,
      "height": height,
      "gender": gender,
      "weight": weight,
      "imageUrl": imageUrl
    };
  }
}
