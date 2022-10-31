import 'package:dicoding_restaurant_app/data/service/restaurant_service.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'restaurant_provider_test.mocks.dart';
import 'package:dicoding_restaurant_app/models/list_restaurant_model.dart';

@GenerateMocks([RestaurantService])
void main() {
  group("RestaurantService", () {
    RestaurantService restaurantService = MockRestaurantService();

    test("Get all return data", () async {
      when(restaurantService.getListRestaurant())
          .thenAnswer((_) async => <Restaurant>[
                Restaurant(
                    id: "s1knt6za9kkfw1e867",
                    name: "Kafe Kita",
                    description:
                        "uisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
                    pictureId: "25",
                    city: "Gorontalo",
                    rating: 4)
              ]);
      var resto = await RestaurantService().getListRestaurant();
      expect(resto != null, true);
    });
  });
}
