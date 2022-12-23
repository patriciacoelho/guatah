import 'dart:developer';
import 'dart:convert';

import 'package:guatah/models/itinerary.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Itinerary>?> getItineraries() async {
    var client = http.Client();

    const apiBaseUrl = String.fromEnvironment('API_BASE_URL');
    log("debug message", error: apiBaseUrl);
    var uri = Uri.parse('$apiBaseUrl/itineraries');
    log("debug message", error: uri);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var data = response.body;
      return itineraryFromJson(data);
    }
  }

  // Future<List<City>?> getCities() async {}
}
