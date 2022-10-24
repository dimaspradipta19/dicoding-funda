import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:dicoding_restaurant_app/models/search_restaurant_model.dart';

class SearchRestaurantService {
  Future<List<Restaurant>?> getSearchRestaurant(String namaResto) async {
    try {
      final response = await http.get(
          Uri.parse("https://restaurant-api.dicoding.dev/search?q=$namaResto"));

      Map<String, dynamic> decodeData = jsonDecode(response.body);
      var model = SearchRestaurantModel.fromJson(decodeData);

      List<Restaurant>? result = model.restaurants;
      return result;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
