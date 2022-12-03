import 'dart:convert';

import 'package:dicoding_restaurant_app/models/review_restaurant_model.dart';
import 'package:http/http.dart' as http;

class ReviewService {
  Future<List<CustomerReview>?> postReview(
      String nama, String review, String id) async {
    try {
      final body = {
        'id': id,
        'name': nama,
        'review': review,
      };
      final response = await http.post(
        Uri.parse("https://restaurant-api.dicoding.dev/review"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> decodedData = jsonDecode(response.body);
        var model = ReviewModel.fromJson(decodedData);

        List<CustomerReview> result = model.customerReviews;
        return result;
      } else {
        throw Exception("Failed to load");
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }
}
