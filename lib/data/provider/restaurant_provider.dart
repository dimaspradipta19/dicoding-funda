import 'package:dicoding_restaurant_app/data/service/restaurant_service.dart';
import 'package:dicoding_restaurant_app/models/list_restaurant_model.dart';
import 'package:flutter/cupertino.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final RestaurantService restaurantService;

  RestaurantProvider({required this.restaurantService}) {
    _fetchListRestaurant();
  }

  late ListRestaurantModel _listRestaurantModel;
  late ResultState _state;
  String _message = "";

  String get message => _message;
  ListRestaurantModel get listRestaurantModel => _listRestaurantModel;
  ResultState get state => _state;

  Future<dynamic> _fetchListRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final list = await RestaurantService().getListRestaurant();
      if (list.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "No Data";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _listRestaurantModel = list;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      // ignore: avoid_print
      print(e.toString());
      return _message = "Error --> $e";
    }
  }
}
