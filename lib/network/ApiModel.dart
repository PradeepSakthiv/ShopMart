import 'dart:convert';

List<ApiModel> userModelFromJson(String str) =>
    List<ApiModel>.from(json.decode(str).map((x) => ApiModel.fromJson(x)));

String userModelToJson(List<ApiModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApiModel {
  ApiModel({
    required this.title,
    required this.description,
    required this.category,
    required this.image,
  });

  String title;
  String description;
  String category;
  String image;

  factory ApiModel.fromJson(Map<String, dynamic> json) => ApiModel(
      title: json["title"],
      description: json["description"],
      category: json["category"],
      image: json["image"]);

  Map<String, dynamic> toJson() => {
        "title": title ,
        "description": description,
        "category": category,
        "image": image,
      };
}
