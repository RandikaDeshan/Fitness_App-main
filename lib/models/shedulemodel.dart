import 'exercisesmodel.dart';

class SheduleModel {
  final int id;
  final String name;
  final String imageUrl;
  final String description;
  final List<ExercisesModel> list;

  SheduleModel(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.description,
      required this.list});

  factory SheduleModel.fromJson(Map<String, dynamic> json) {
    return SheduleModel(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        description: json["description"],
        list: List<ExercisesModel>.from(json["list"]));
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "imageUrl": imageUrl,
      "list": list,
    };
  }
}
