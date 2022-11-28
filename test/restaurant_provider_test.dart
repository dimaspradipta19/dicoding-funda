// import 'package:dicoding_restaurant_app/data/service/restaurant_service.dart';
import 'package:test/test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:mockito/annotations.dart';
// import 'restaurant_provider_test.mocks.dart';
import 'package:dicoding_restaurant_app/models/list_restaurant_model.dart';
// import 'package:http/http.dart' as http;

// @GenerateMocks([RestaurantService])
// void main() {
//   group(
//     "RestaurantService",
//     () {
//       RestaurantService restaurantService = MockRestaurantService();

//       test(
//         "Get all return data",
//         () async {
//           when(restaurantService.getListRestaurant())
//               .thenAnswer((_) async => <Restaurant>[
//                     Restaurant(
//                         id: "s1knt6za9kkfw1e867",
//                         name: "Kafe Kita",
//                         description:
//                             "uisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
//                         pictureId: "25",
//                         city: "Gorontalo",
//                         rating: 4)
//                   ]);
//           var resto = await RestaurantService().getListRestaurant();
//           expect(resto != null, true);
//         },
//       );
//     },
//   );
// }

void main() {
  test('memparsing json ke restaurant model', () {
    const id = "abcdefghijklmnopqrs";
    const name = "Dim Dum Restaurant Italiano";
    const description = "Ini adalah restoran Italia terbesar ke 2";
    const pictureId = "12";
    const city = "Bekasi";
    const double rating = 4.8;

    final json = {
      "id": "abcdefghijklmnopqrs",
      "name": "Dim Dum Restaurant Italiano",
      "description": "Ini adalah restoran Italia terbesar ke 2",
      "pictureId": "12",
      "city": "Bekasi",
      "rating": 4.8
    };

    Restaurant result = Restaurant.fromJson(json);
    expect(result.id, id);
    expect(result.name, name);
    expect(result.description, description);
    expect(result.pictureId, pictureId);
    expect(result.city, city);
    expect(result.rating, rating);
  });
}
