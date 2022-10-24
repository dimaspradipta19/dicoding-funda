import 'package:dicoding_restaurant_app/data/provider/restaurant_provider.dart';
import 'package:dicoding_restaurant_app/models/detail_restaurant_model.dart';
import 'package:flutter/cupertino.dart';

import '../service/detail_restaurant_service.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  DetailRestaurantService service = DetailRestaurantService();
  DetailRestaurantModel? detailRestaurantModel;
  ResultState state = ResultState.noData;

  Future<dynamic> getDetail(String id) async {
    detailRestaurantModel = await service.getDetailRestaurant(id);

    // print(detailRestaurantModel);
    // if (result != null) {
    //   detailRestaurantModel = result;
    //   notifyListeners();
    // } else {
    //   print("Error");
    //   print(detailRestaurantModel?.restaurant.city ?? "Kosong");
    //   notifyListeners();
    // }
    notifyListeners();
    return detailRestaurantModel;
  }
}
