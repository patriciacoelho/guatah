
import 'dart:convert';

import 'package:uuid/uuid.dart';

List<Category> categoryFromJson(String str) {
  var data = json.decode(str);

  if (data['categories'] != null) {
    data = data['categories'];
  }
  return List<Category>.from(data.map((value) => Category.fromJson(value)));
}

class Category {
  Category({
    required this.id,
    required this.image_url,
    required this.name,
  });

  String id;
  String image_url;
  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['_id'] ?? const Uuid().v4(),
    image_url: json['logo_url'] ?? '',
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'image_url': image_url,
    'name': name,
  };
}
