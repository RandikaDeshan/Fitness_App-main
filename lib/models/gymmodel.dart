class GymModel {
  final String id;
  final bool open;
  GymModel({required this.id, required this.open});

  factory GymModel.fromJson(Map<String, dynamic> json) {
    return GymModel(id: json["id"], open: json["open"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "open": open};
  }
}
