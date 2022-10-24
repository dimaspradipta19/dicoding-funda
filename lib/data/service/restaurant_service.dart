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
  // GET listRestaurant
  // Future<ListRestaurantModel> getListRestaurant() async {
  //   final response = await http.get(Uri.parse(_baseUrl + _list));

  //   if (response.statusCode == 200) {
  //     return ListRestaurantModel.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception("Failed to load List Restaurant");
  //   }
  // }

  // GET detailRestaurant
  // Future<DetailRestaurantModel> getDetailRestaurant(String id) async {
  //   final response = await http
  //       .get(Uri.parse("https://restaurant-api.dicoding.dev/detail/$id"));

  //   if (response.statusCode == 200) {
  //     final decodedData = jsonDecode(response.body);
  //     final result = DetailRestaurantModel.fromJson(decodedData);
  //     return result;
  //   } else {
  //     throw Exception("Failed get detail restaurant");
  //   }
  // }
}
