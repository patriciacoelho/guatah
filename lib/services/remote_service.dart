import 'dart:developer';
import 'dart:convert';

import 'package:guatah/models/itinerary.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Itinerary>?> getItineraries() async {
    var client = http.Client();

    var uri = Uri.parse('https://fb48-2804-5fb8-c005-7200-e095-3702-58d-6ecd.sa.ngrok.io/itineraries');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var data = response.body;
      return itineraryFromJson(data);
    }
  }
}
