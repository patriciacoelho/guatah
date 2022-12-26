
import 'dart:convert';

import 'package:uuid/uuid.dart';

List<Operator> operatorFromJson(String str) {
  var data = json.decode(str);

  if (data['operator'] != null) {
    data = data['operator'];
    return List<Operator>.from([data].map((value) => Operator.fromJson(value)));
  }

  if (data['operators'] != null) {
    data = data['operators'];
  }
  return List<Operator>.from(data.map((value) => Operator.fromJson(value)));
}

class Operator {
  Operator({
    required this.id,
    required this.pickup_city_ids,
    required this.image_url,
    required this.name,
    required this.type,
    this.description,
    this.instagram,
    this.site,
    this.whatsapp,
  });

  String id;
  List<String> pickup_city_ids;
  String image_url;
  String name;
  String type;
  String? description;
  String? instagram;
  String? site;
  String? whatsapp;

  factory Operator.fromJson(Map<String, dynamic> json) => Operator(
    id: json['_id'] ?? const Uuid().v4(),
    pickup_city_ids: json['pickup_city_ids'].cast<String>(),
    image_url: json['logo_url'] ?? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6bkZX4V5o8QaYeLVo2nYurPqwOS4hDeVytU5BCz7NOPUC9hLp0vZDYIofJzDBpT2XHhc&usqp=CAU',
    name: json['name'],
    type: json['type'],
    description: json['description'],
    instagram: json['social_networks']['instagram'],
    site: json['social_networks']['site'],
    whatsapp: json['social_networks']['whatsapp'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'pickup_city_ids': pickup_city_ids,
    'image_url': image_url,
    'name': name,
    'type': type,
    'description': description,
    'instagram': instagram,
    'site': site,
    'whatsapp': whatsapp,
  };
}
