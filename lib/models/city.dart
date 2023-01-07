
import 'dart:convert';

import 'package:uuid/uuid.dart';

List<City> cityFromJson(String str) {
  var data = json.decode(str);

  if (data['cities'] != null) {
    data = data['cities'];
  }
  return List<City>.from(data.map((value) => City.fromJson(value)));
}

class City {
  City({
    required this.id,
    required this.uf,
    required this.name,
  });

  String id;
  String uf;
  String name;

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json['_id'] ?? const Uuid().v4(),
    uf: json['uf'] ?? '',
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'uf': uf,
    'name': name,
  };
}
