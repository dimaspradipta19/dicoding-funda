import 'package:dicoding_restaurant_app/data/provider/restaurant_provider.dart';
import 'package:dicoding_restaurant_app/data/service/restaurant_service.dart';
import 'package:dicoding_restaurant_app/models/detail_restaurant_model.dart';
import 'package:flutter/cupertino.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final RestaurantService restaurantService;
  final String id;

  DetailRestaurantProvider(
      {required this.restaurantService, required this.id}) {
    _fetchDetailRestaurant(id);
  }

  late DetailRestaurantModel _detailRestaurantModel;
  late ResultState _state;
  String _message = "";

  String get message => _message;
  ResultState get state => _state;
  DetailRestaurantModel get detailRestaurant => _detailRestaurantModel;

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final detail = await restaurantService.getDetailRestaurant(id);
      if (detail.error!) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state == ResultState.hasData;
        notifyListeners();
        return _detailRestaurantModel = detail;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      // ignore: avoid_print
      print(e.toString());
      return _message = "Error";
    }
  }
}
