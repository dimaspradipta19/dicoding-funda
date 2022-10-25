import 'dart:io';

import 'package:dicoding_restaurant_app/data/service/restaurant_service.dart';
import 'package:dicoding_restaurant_app/models/list_restaurant_model.dart';
import 'package:flutter/cupertino.dart';

enum ResultState { loading, noData, hasData, error }

class ListRestaurantProvider extends ChangeNotifier {
  RestaurantService service = RestaurantService();
  List<Restaurant> result = [];
  ResultState state = ResultState.noData;

  void getList() async {
    try {
      state = ResultState.loading;
      notifyListeners();
      result = await service.getListRestaurant() ?? [];
      if (result == []) {
        state = ResultState.noData;
      } else {
        state = ResultState.hasData;
      }
      notifyListeners();
    } on SocketException {
      throw Exception("Gagal menyambung server");
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
