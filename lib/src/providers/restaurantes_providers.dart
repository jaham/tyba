import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tyba/src/models/restaurante_model.dart';

class RestaurantesProviders {
  String _apikey = '33d98b22241e84a5d53df5ff8496b1de';
  String _url = 'developers.zomato.com';
  Map<String, String> userHeader = {
    "Accept": "application/json",
    "user-key": "33d98b22241e84a5d53df5ff8496b1de"
  };

  Future<List<RestaurantElement>> getCitie(citie) async {
    final url = Uri.https(_url, 'api/v2.1/search', {
      'user-key': _apikey,
      'q': citie,
    });

    final resp = await http.get(url, headers: userHeader);
    final decodeData = json.decode(resp.body);

    final citi = Restaurante.fromJson(decodeData).restaurants;

    return citi;
  }
}
