import 'dart:convert';
import 'dart:developer';

import 'package:dicoding_restaurant_app/models/list_restaurant_model.dart';
import 'package:http/http.dart' as http;

class RestaurantService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev/";
  static const String _list = "list";

  Future<List<Restaurant>?> getListRestaurant() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + _list));

      Map<String, dynamic> decodeData = jsonDecode(response.body);
      var model = ListRestaurantModel.fromJson(decodeData);

      List<Restaurant>? result = model.restaurants;
      return result;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
