import 'dart:convert';

import 'package:guatah/models/category.dart';
import 'package:guatah/models/city.dart';
import 'package:guatah/models/itinerary.dart';
import 'package:guatah/models/operator.dart';
import 'package:guatah/models/tagged.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Itinerary>?> getItineraries(Map<String, dynamic>? params) async {
    var client = http.Client();
    const apiBaseUrl = String.fromEnvironment('API_BASE_URL');

    String queryString = Uri(queryParameters: params).query;
    var uri = Uri.parse('$apiBaseUrl/itineraries?$queryString');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var data = response.body;
      return itineraryFromJson(data);
    }
    return null;
  }

  Future<Itinerary?> getItineraryDetails({required String id}) async {
    var client = http.Client();

    const apiBaseUrl = String.fromEnvironment('API_BASE_URL');
    var uri = Uri.parse('$apiBaseUrl/itineraries/$id');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var data = response.body;
      return itineraryFromJson(data)[0];
    }
    return null;
  }

  Future<List<Operator>?> getOperators(Map<String, dynamic>? params) async {
    var client = http.Client();
    const apiBaseUrl = String.fromEnvironment('API_BASE_URL');

    String queryString = Uri(queryParameters: params).query;
    var uri = Uri.parse('$apiBaseUrl/operators?$queryString');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var data = response.body;
      return operatorFromJson(data);
    }
    return null;
  }

  Future<Operator?> getOperator({required String id}) async {
    var client = http.Client();

    const apiBaseUrl = String.fromEnvironment('API_BASE_URL');
    var uri = Uri.parse('$apiBaseUrl/operators/$id');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var data = response.body;
      return operatorFromJson(data)[0];
    }
    return null;
  }

  Future<List<Category>?> getCategories() async {
    var client = http.Client();

    const apiBaseUrl = String.fromEnvironment('API_BASE_URL');
    var uri = Uri.parse('$apiBaseUrl/categories');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var data = response.body;
      return categoryFromJson(data);
    }
    return null;
  }

  Future<List<Tagged>?> getTagged(Map<String, dynamic>? params) async {
    // TODO - utilizar userId do usuário logado
    const userId = '632c33609cd2d2830bde5c0b';
    var client = http.Client();
    const apiBaseUrl = String.fromEnvironment('API_BASE_URL');

    String queryString = Uri(queryParameters: params).query;
    var uri = Uri.parse('$apiBaseUrl/taggeds/$userId?$queryString');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var data = response.body;
      return taggedFromJson(data);
    }
    return null;
  }

  dynamic createTagged(Map<String, dynamic>? payload) async {
    // TODO - utilizar userId do usuário logado
    const userId = '632c33609cd2d2830bde5c0b';
    var client = http.Client();
    const apiBaseUrl = String.fromEnvironment('API_BASE_URL');

    var uri = Uri.parse('$apiBaseUrl/taggeds');
    var response = await client.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String?>{
        'user_id': userId,
        'already_know': payload!['trip_id'] != null ? 'true' : 'false',
        'trip_id': payload['trip_id'],
        'itinerary_id': payload['itinerary_id'],
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return 'Roteiro marcado com sucesso!';
    } else {
      throw Exception('Falha ao marcar roteiro.');
    }
  }

  Future<List<City>?> getCities() async {
    var client = http.Client();

    const apiBaseUrl = String.fromEnvironment('API_BASE_URL');
    var uri = Uri.parse('$apiBaseUrl/cities');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var data = response.body;
      return cityFromJson(data);
    }
    return null;
  }
}
