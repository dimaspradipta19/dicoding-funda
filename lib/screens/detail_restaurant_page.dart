import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/data/provider/detail_restaurant_provider.dart';
import 'package:dicoding_restaurant_app/data/provider/restaurant_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailRestaurant extends StatefulWidget {
  const DetailRestaurant({
    super.key,
    required this.idResto,
  });
  final String idResto;

  @override
  State<DetailRestaurant> createState() => _DetailRestaurantState();
}

class _DetailRestaurantState extends State<DetailRestaurant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailRestaurantProvider>(
        builder: (context, DetailRestaurantProvider detailRestaurant, _) {
          if (detailRestaurant.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (detailRestaurant.state == ResultState.hasData) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                          child: Image.network(
                              "https://restaurant-api.dicoding.dev/images/medium/${detailRestaurant.detailRestaurantModel?.restaurant.pictureId}"),
                        ),
                        Container(
                          decoration:
                              const BoxDecoration(color: secondaryColor),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: primaryColor,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // "detail.detail.restaurant.name",
                            detailRestaurant
                                    .detailRestaurantModel?.restaurant.name ??
                                "Resto Name",
                            style: myTextTheme.displaySmall!
                                .copyWith(fontSize: 24),
                          ),
                          const SizedBox(height: 12.0),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: primaryColor,
                              ),
                              Text(
                                detailRestaurant.detailRestaurantModel
                                        ?.restaurant.city ??
                                    "City Resto",
                                style: myTextTheme.bodyLarge!
                                    .copyWith(fontSize: 18.0),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12.0),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: primaryColor,
                              ),
                              Text(
                                // "Restaurant rating",
                                detailRestaurant.detailRestaurantModel
                                        ?.restaurant.rating
                                        .toString() ??
                                    "Rating",
                                style: myTextTheme.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12.0),
                          Text(
                            // "restaurant.description!"
                            detailRestaurant.detailRestaurantModel?.restaurant
                                    .description ??
                                "decs",
                            textAlign: TextAlign.justify,
                            style: myTextTheme.bodyText1,
                          ),
                          const SizedBox(height: 18.0),
                          // MAKANAN
                          Text(
                            "Makanan",
                            style: myTextTheme.headline6,
                          ),
                          SizedBox(
                            height: 150,
                            child: ListView.builder(
                              itemCount: detailRestaurant.detailRestaurantModel!.restaurant.menus.foods.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[350],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 20),
                                          const FlutterLogo(size: 60.0),
                                          const SizedBox(height: 20),
                                          Text(detailRestaurant
                                              .detailRestaurantModel!
                                              .restaurant
                                              .menus
                                              .foods[index]
                                              .name)
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 18.0),
                          Text(
                            "Minuman",
                            style: myTextTheme.headline6,
                          ),
                          // MINUMAN
                          SizedBox(
                            height: 150,
                            child: ListView.builder(
                              itemCount: detailRestaurant.detailRestaurantModel!.restaurant.menus.drinks.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[350],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 20),
                                          const FlutterLogo(size: 60.0),
                                          const SizedBox(height: 20),
                                          Text(detailRestaurant
                                              .detailRestaurantModel!
                                              .restaurant
                                              .menus
                                              .drinks[index]
                                              .name),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 12.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (detailRestaurant.state == ResultState.noData) {
            return const Text("No Data");
          } else if (detailRestaurant.state == ResultState.error) {
            return const Text("Error");
          } else {
            return const Text("");
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: whiteColor,
                  side: const BorderSide(color: primaryColor),
                ),
                onPressed: () {},
                child: Text(
                  "PESAN SEKARANG",
                  style: myTextTheme.button!.copyWith(color: primaryColor),
                ),
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                onPressed: () {},
                child: Row(
                  children: [
                    const Icon(
                      Icons.add,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text("RESERVASI", style: myTextTheme.button),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
