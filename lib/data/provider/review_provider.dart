import 'package:dicoding_restaurant_app/data/service/review_service.dart';
import 'package:dicoding_restaurant_app/models/review_restaurant_model.dart';
import 'package:dicoding_restaurant_app/utils/result_state.dart';
import 'package:flutter/cupertino.dart';

class ReviewProvider with ChangeNotifier {
  ReviewService service = ReviewService();
  List<CustomerReview> listReview = [];
  ResultState state = ResultState.noData;

  void review(String id, String nama, String review) async {
    try {
      state = ResultState.loading;
      notifyListeners();

      List<CustomerReview>? result = await service.postReview(nama, review, id);

      if (result == []) {
        state = ResultState.noData;
        notifyListeners();
      } else {
        state = ResultState.hasData;
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
