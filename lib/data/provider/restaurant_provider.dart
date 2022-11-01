import 'dart:io';

import 'package:dicoding_restaurant_app/data/service/restaurant_service.dart';
import 'package:dicoding_restaurant_app/models/list_restaurant_model.dart';
import 'package:flutter/cupertino.dart';
import '../../utils/result_state.dart';


class ListRestaurantProvider extends ChangeNotifier {
  RestaurantService service = RestaurantService();
  List<Restaurant> result = [];
  ResultState state = ResultState.noData;

  // cara alterra
  void getList() async {
    try {
      state = ResultState.loading;
      notifyListeners();
      result = await service.getListRestaurant() ?? [];
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
      // ignore: avoid_print
      print(e.toString());
      rethrow;
    }
  }

  // cara dicoding
  // void getList() async {
  //   try {
  //     state = ResultState.loading;
  //     notifyListeners();
  //     final result = await service.getListRestaurant();
  //     if (result.restaurants.isNotEmpty) {
  //       state = ResultState.hasData;
  //       notifyListeners();
  //     } else {
  //       state = ResultState.noData;
  //       notifyListeners();
  //     }
  //     notifyListeners();
  //   } on SocketException {
  //     throw Exception("Gagal menyambung server");
  //   } catch (e) {
  //     // ignore: avoid_print
  //     print(e.toString());
  //     rethrow;
  //   }
  // }
}
