class SheduleModel {
  final String id;
  final int days;
  final String name;
  final String imageUrl;
  final String description;

  SheduleModel({
    required this.id,
    required this.days,
    required this.name,
    required this.imageUrl,
    required this.description,
  });

  factory SheduleModel.fromJson(Map<String, dynamic> json) {
    return SheduleModel(
      id: json["id"],
      days: json["days"],
      name: json["name"],
      imageUrl: json["imageUrl"],
      description: json["description"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "days": days,
      "name": name,
      "imageUrl": imageUrl,
      "description": description,
    };
  }
}
