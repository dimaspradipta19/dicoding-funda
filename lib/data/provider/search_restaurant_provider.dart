import 'dart:io';

import 'package:dicoding_restaurant_app/data/service/search_restaurant_service.dart';
import 'package:dicoding_restaurant_app/models/search_restaurant_model.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/result_state.dart';

class SearchRestaurantProvider with ChangeNotifier {
  SearchRestaurantService service = SearchRestaurantService();
  List<Restaurant> result = [];
  ResultState state = ResultState.noData;

  void getSearch(String namaResto) async {
    try {
      state = ResultState.loading;
      notifyListeners();
      result = await service.getSearchRestaurant(namaResto) ?? [];
      if (result == []) {
        state = ResultState.noData;
        notifyListeners();
      } else {
        state = ResultState.hasData;
        notifyListeners();
      }
      notifyListeners();
    } on SocketException {
      throw Exception("Gagal menyambung server");
    } catch (e) {
      rethrow;
    }
  }
}
