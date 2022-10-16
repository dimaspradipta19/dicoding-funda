import 'dart:convert';

import 'package:dicoding_restaurant_app/models/detail_restaurant_model.dart';
import 'package:dicoding_restaurant_app/models/list_restaurant_model.dart';
import 'package:http/http.dart' as http;

class RestaurantService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev/";
  static const String _list = "list";
  static const String _detailRestaurant = "detail/";

  // GET listRestaurant
  Future<ListRestaurantModel> getListRestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl + _list));

    if (response.statusCode == 200) {
      return ListRestaurantModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load List Restaurant");
    }
  }

  // GET detailRestaurant
  Future<DetailRestaurantModel> getDetailRestaurant(String id) async {
    final response =
        await http.get(Uri.parse(_baseUrl + _detailRestaurant + id));

    if (response.statusCode == 200) {
      return DetailRestaurantModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed get detail restaurant");
    }
  }
}
