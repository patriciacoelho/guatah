
import 'dart:convert';

import 'package:uuid/uuid.dart';

List<Tagged> taggedFromJson(String str) {
  var data = json.decode(str);

  if (data['taggeds'] != null) {
    data = data['taggeds'];
  }
  return List<Tagged>.from(data.map((value) => Tagged.fromJson(value)));
}

class Tagged {
  Tagged({
    required this.id,
    required this.userId,
    required this.trip_name,
    required this.image_url,
    this.operator_name,
    this.date,
    this.classification,
    this.tripId,
    this.itineraryId,
    required this.alreadyKnow,
  });

  String id;
  String userId;
  String trip_name;
  String? operator_name;
  String? date;
  String? classification;
  String image_url;
  String? tripId;
  String? itineraryId;
  bool alreadyKnow;

  factory Tagged.fromJson(Map<String, dynamic> json) => Tagged(
    id: json['_id'] ?? const Uuid().v4(),
    userId: json['user_id'] ?? '',
    image_url: json['image_url'] ?? '',
    trip_name: json['trip_name'],
    date: json['formatted_date'],
    operator_name: json['operator_name'],
    classification: json['classification'],
    tripId: json['trip_id'], 
    itineraryId: json['itinerary_id'], 
    alreadyKnow: json['already_know'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'trip_name': trip_name,
    'operator_name': operator_name,
    'date': date,
    'image_url': image_url,
    'classification': classification,
    'trip_id': tripId,
    'itinerary_id': itineraryId,
    'already_know': alreadyKnow,
  };
}
