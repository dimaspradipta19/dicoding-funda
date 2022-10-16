import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/data/provider/detail_restaurant_provider.dart';
import 'package:dicoding_restaurant_app/data/service/restaurant_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailRestaurant extends StatelessWidget {
  const DetailRestaurant({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DetailRestaurantProvider(
          restaurantService: RestaurantService(), id: id),
      child: Scaffold(
        body: Consumer<DetailRestaurantProvider>(
          builder:
              (context, DetailRestaurantProvider detailRestaurant, child) =>
                  SafeArea(
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
                            "https://restaurant-api.dicoding.dev/images/medium/${detailRestaurant.detail.restaurant.pictureId}"),
                        // child: FlutterLogo(
                        //   size: 200,
                        // ),
                      ),
                      Container(
                        decoration: const BoxDecoration(color: secondaryColor),
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
                          detailRestaurant.detail.restaurant.name,
                          style:
                              myTextTheme.displaySmall!.copyWith(fontSize: 24),
                        ),
                        const SizedBox(height: 12.0),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: primaryColor,
                            ),
                            Text(
                              detailRestaurant.detail.restaurant.city,
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
                              detailRestaurant.detail.restaurant.rating
                                  .toString(),
                              style: myTextTheme.bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          // "restaurant.description!"
                          detailRestaurant.detail.restaurant.description,
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
                            itemCount: 10,
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
                                        Text(detailRestaurant.detail.restaurant
                                            .menus.foods[index].name),
                                        // Text(detail.detail.restaurant.menus
                                        //     .foods[index].name),
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
                            itemCount: 10,
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
                                        // Text(
                                        //     "restaurant.menus.drinks[index].name"),
                                        Text(detailRestaurant.detail.restaurant
                                            .menus.drinks[index].name),
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
          ),
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
                  style:
                      ElevatedButton.styleFrom(backgroundColor: primaryColor),
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
      ),
    );
  }
}
