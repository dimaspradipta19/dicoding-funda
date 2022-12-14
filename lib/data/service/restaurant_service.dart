import 'dart:convert';
import 'dart:developer';

import 'package:dicoding_restaurant_app/models/list_restaurant_model.dart';
import 'package:http/http.dart' as http;

class RestaurantService {
  final String _baseUrl = "https://restaurant-api.dicoding.dev/";
  final String _list = "list";

  // cara alterra
  Future<List<Restaurant>?> getListRestaurant() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + _list));

      if (response.statusCode == 200) {
        Map<String, dynamic> decodeData = jsonDecode(response.body);
        var model = ListRestaurantModel.fromJson(decodeData);

        List<Restaurant>? result = model.restaurants;
        return result;
      } else {
        throw Exception("Failed load List Resto");
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // cara dicoding
  // Future<ListRestaurantModel> getListRestaurant() async {
  //   final response = await http.get(Uri.parse(_baseUrl + _list));

  //   if (response.statusCode == 200) {
  //     // Map<String, dynamic> decodeData = jsonDecode(response.body);
  //     var model = ListRestaurantModel.fromJson(jsonDecode(response.body));

  //     // ListRestaurantModel result = model.restaurants;
  //     return model;
  //   } else {
  //     throw Exception("Failed load List Resto");
  //   }
  // }
}
