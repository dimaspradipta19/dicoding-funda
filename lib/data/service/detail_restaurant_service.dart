import 'dart:convert';
import 'dart:developer';

import 'package:dicoding_restaurant_app/models/detail_restaurant_model.dart';
import 'package:http/http.dart' as http;

class DetailRestaurantService {
  // GET detailRestaurant
  Future<DetailRestaurantModel?> getDetailRestaurant(String id) async {
    DetailRestaurantModel? result;
    try {
      final response = await http
          .get(Uri.parse("https://restaurant-api.dicoding.dev/detail/$id"));

      if (response.statusCode == 200) {
        Map<String, dynamic> decodeData = jsonDecode(response.body);
        result = DetailRestaurantModel.fromJson(decodeData);
        return result;
      } else {
        log("Error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }
}
