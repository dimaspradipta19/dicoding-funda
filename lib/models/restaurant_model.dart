// import 'dart:convert';

// RestaurantModel restaurantModelFromJson(String str) =>
//     RestaurantModel.fromJson(json.decode(str));

// String restaurantModelToJson(RestaurantModel data) =>
//     json.encode(data.toJson());

// class RestaurantModel {
//   RestaurantModel({
//     required this.restaurants,
//   });

//   List<Restaurant> restaurants;

//   factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
//       RestaurantModel(
//         restaurants: List<Restaurant>.from(
//             json["restaurants"].map((x) => Restaurant.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
//       };
// }

// List<Restaurant> parseRestaurant(String? json) {
//   if (json == null) {
//     return [];
//   }

//   final List parsed = jsonDecode(json)["restaurants"];
//   return parsed.map((json) => Restaurant.fromJson(json)).toList();
// }

// class Restaurant {
//   Restaurant({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.pictureId,
//     required this.city,
//     required this.rating,
//     required this.menus,
//   });

//   String id;
//   String name;
//   String description;
//   String pictureId;
//   String city;
//   double rating;
//   Menus menus;

//   factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
//         id: json["id"],
//         name: json["name"],
//         description: json["description"],
//         pictureId: json["pictureId"],
//         city: json["city"],
//         rating: json["rating"].toDouble(),
//         menus: Menus.fromJson(json["menus"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "description": description,
//         "pictureId": pictureId,
//         "city": city,
//         "rating": rating,
//         "menus": menus.toJson(),
//       };
// }

// class Menus {
//   Menus({
//     required this.foods,
//     required this.drinks,
//   });

//   List<Drink> foods;
//   List<Drink> drinks;

//   factory Menus.fromJson(Map<String, dynamic> json) => Menus(
//         foods: List<Drink>.from(json["foods"].map((x) => Drink.fromJson(x))),
//         drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
//         "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
//       };
// }

// class Drink {
//   Drink({
//     required this.name,
//   });

//   String name;

//   factory Drink.fromJson(Map<String, dynamic> json) => Drink(
//         name: json["name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//       };
// }