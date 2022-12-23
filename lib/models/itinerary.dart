import 'dart:developer';
import 'dart:convert';
import 'package:uuid/uuid.dart';

List<Itinerary> itineraryFromJson(String str) {
  var data = json.decode(str);
  // log('is object', error: data['itinerary'] != null);
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
    this.price,
    this.date,
    this.description,
    required this.classification,
    required this.trip_id,
    required this.operator_id,
  });

  String id;
  List<String> pickup_city_ids;
  num? price;
  final date;
  String? description;
  String classification;
  String trip_id;
  String operator_id;

  factory Itinerary.fromJson(Map<String, dynamic> json) => Itinerary(
    id: json['id'] ?? const Uuid().v4(),
    pickup_city_ids: json['pickup_city_ids'].cast<String>(),
    price: json['price'],
    date: json['date'],
    description: json['description'],
    classification: json['classification'],
    trip_id: json['trip_id'],
    operator_id: json['operator_id'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'pickup_city_ids': pickup_city_ids,
    'price': price,
    'date': date,
    'description': description,
    'classification': classification,
    'trip_id': trip_id,
    'operator_id': operator_id,
  };
}
