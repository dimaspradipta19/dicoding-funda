import 'dart:io';

import 'package:dicoding_restaurant_app/models/detail_restaurant_model.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/result_state.dart';
import '../service/detail_restaurant_service.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  DetailRestaurantService service = DetailRestaurantService();
  DetailRestaurantModel? detailRestaurantModel;
  ResultState state = ResultState.noData;

  Future<dynamic> getDetail(String id) async {
    try {
      state = ResultState.loading;
      notifyListeners();
      detailRestaurantModel = await service.getDetailRestaurant(id);
      if (detailRestaurantModel == null) {
        state = ResultState.noData;
        notifyListeners();
      } else {
        state = ResultState.hasData;
        notifyListeners();
      }
      notifyListeners();
      // return detailRestaurantModel;
    } on SocketException {
      throw Exception("Gagal menyambung server");
    } catch (e) {
      rethrow;
    }
  }
}
