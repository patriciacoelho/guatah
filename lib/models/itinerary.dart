import 'dart:developer';
import 'dart:convert';
import 'package:uuid/uuid.dart';

List<Itinerary> itineraryFromJson(String str) {
  var data = json.decode(str);

  if (data['itinerary'] != null) {
    data = data['itinerary'];
    return List<Itinerary>.from([data].map((value) => Itinerary.fromJson(value)));
  }

  if (data['itineraries'] != null) {
    data = data['itineraries'];
  }
  return List<Itinerary>.from(data.map((value) => Itinerary.fromJson(value)));
}

String itineraryToJson(List<Itinerary> data) => json.encode(List<dynamic>.from(data.map((value) => value.toJson())));

class Itinerary {
  Itinerary({
    required this.id,
    required this.pickup_city_ids,
    required this.image_url,
    required this.trip_name,
    required this.operator_name,
    this.price,
    required this.date,
    this.description,
    required this.classification,
    required this.trip_id,
    required this.operator_id,
    this.instagram,
    this.site,
    this.whatsapp,
  });

  String id;
  List<String> pickup_city_ids;
  String image_url;
  String trip_name;
  String operator_name;
  num? price;
  String date;
  String? description;
  String classification;
  String trip_id;
  String operator_id;
  String? instagram;
  String? site;
  String? whatsapp;

  factory Itinerary.fromJson(Map<String, dynamic> json) => Itinerary(
    id: json['_id'] ?? const Uuid().v4(),
    pickup_city_ids: json['pickup_city_ids'].cast<String>(),
    image_url: json['trip']['image_url'],
    trip_name: json['trip']['name'],
    operator_name: json['operator']['name'],
    price: json['price'],
    date: json['formatted_date'],
    description: json['description'],
    classification: json['classification'],
    trip_id: json['trip_id'],
    operator_id: json['operator_id'],
    instagram: json['operator']['social_networks']['instagram'],
    site: json['operator']['social_networks']['site'],
    whatsapp: json['operator']['social_networks']['whatsapp'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'pickup_city_ids': pickup_city_ids,
    'price': price,
    'image_url': image_url,
    'trip_name': trip_name,
    'operator_name': operator_name,
    'date': date,
    'description': description,
    'classification': classification,
    'trip_id': trip_id,
    'operator_id': operator_id,
    'instagram': instagram,
    'site': site,
    'whatsapp': whatsapp,
  };
}
