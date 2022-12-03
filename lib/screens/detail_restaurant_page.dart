import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/data/provider/detail_restaurant_provider.dart';
import 'package:dicoding_restaurant_app/data/service/detail_restaurant_service.dart';
import 'package:dicoding_restaurant_app/data/service/review_service.dart';
import 'package:dicoding_restaurant_app/screens/review_page.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import '../common/internet_not_connected.dart';
import '../utils/result_state.dart';

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
    // final builder = DetailRestaurant(idResto: widget.idResto);

    return Scaffold(
      body: FutureBuilder(
        future: DetailRestaurantService().getDetailRestaurant(widget.idResto),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Visibility(
                      visible: Provider.of<InternetConnectionStatus>(context) ==
                          InternetConnectionStatus.disconnected,
                      child: const InternetNotAvailable(),
                    ),
                    Provider.of<InternetConnectionStatus>(context) ==
                            InternetConnectionStatus.disconnected
                        ? const Text("check your internet!")
                        : Column(
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0),
                                    ),
                                    child: Image.network(
                                        "https://restaurant-api.dicoding.dev/images/medium/${snapshot.data!.restaurant.pictureId}"),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                            color: secondaryColor),
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
                                ],
                              ),
                              const SizedBox(height: 12.0),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            snapshot.data?.restaurant.name ??
                                                "Resto Name",
                                            style: myTextTheme.displaySmall!
                                                .copyWith(fontSize: 36),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.star_rounded,
                                          color: primaryColor,
                                          size: 30,
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          snapshot.data?.restaurant.rating
                                                  .toString() ??
                                              "Rating",
                                          style: myTextTheme.headline5!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12.0),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on_outlined,
                                          color: primaryColor,
                                          size: 30,
                                        ),
                                        const SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data?.restaurant
                                                      .address ??
                                                  "City Resto",
                                              style: myTextTheme.bodyLarge!
                                                  .copyWith(fontSize: 16.0),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              snapshot.data?.restaurant.city ??
                                                  "City Resto",
                                              style: myTextTheme.bodyLarge!
                                                  .copyWith(fontSize: 16.0),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 24.0),
                                    SizedBox(
                                      height: 50,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot
                                            .data?.restaurant.categories.length,
                                        itemBuilder: (context, index) =>
                                            Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Chip(
                                            padding: const EdgeInsets.all(10),
                                            backgroundColor: primaryColor,
                                            label: Text(
                                              snapshot.data!.restaurant
                                                  .categories[index].name,
                                              style: const TextStyle(
                                                  color: whiteColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 24.0),
                                    Text(
                                      snapshot.data?.restaurant.description ??
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
                                        itemCount: snapshot.data?.restaurant
                                            .menus.foods.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 150,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[350],
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    const SizedBox(height: 20),
                                                    const FlutterLogo(
                                                        size: 60.0),
                                                    const SizedBox(height: 20),
                                                    Text(snapshot
                                                        .data!
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
                                        itemCount: snapshot.data?.restaurant
                                            .menus.drinks.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 150,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[350],
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    const SizedBox(height: 20),
                                                    const FlutterLogo(
                                                        size: 60.0),
                                                    const SizedBox(height: 20),
                                                    Text(snapshot
                                                        .data!
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
                                    Text(
                                      "Reviews",
                                      style: myTextTheme.headline6,
                                    ),
                                    // REVIEW
                                    SizedBox(
                                      height: 130,
                                      child: ListView.builder(
                                        itemCount: snapshot.data?.restaurant
                                            .customerReviews.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 300,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Nama : ${snapshot.data?.restaurant.customerReviews[index].name}",
                                                      style:
                                                          myTextTheme.bodyLarge,
                                                    ),
                                                    Text(
                                                        "Tanggal: ${snapshot.data?.restaurant.customerReviews[index].date}"),
                                                    Expanded(
                                                      child: Text(
                                                        snapshot
                                                            .data!
                                                            .restaurant
                                                            .customerReviews[
                                                                index]
                                                            .review,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.none) {
            return const Center(
              child: Text("No Data"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      // Consumer<DetailRestaurantProvider>(
      //   builder: (context, DetailRestaurantProvider detailRestaurant, _) {
      //     if (detailRestaurant.state == ResultState.loading) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     } else if (detailRestaurant.state == ResultState.hasData) {
      //       return SafeArea(
      //         child: SingleChildScrollView(
      //           child: Column(
      //             children: [
      //               Visibility(
      //                 visible: Provider.of<InternetConnectionStatus>(context) ==
      //                     InternetConnectionStatus.disconnected,
      //                 child: const InternetNotAvailable(),
      //               ),
      //               Provider.of<InternetConnectionStatus>(context) ==
      //                       InternetConnectionStatus.disconnected
      //                   ? const Text("check your internet!")
      //                   : Column(
      //                       children: [
      //                         Stack(
      //                           children: [
      //                             ClipRRect(
      //                               borderRadius: const BorderRadius.only(
      //                                 bottomLeft: Radius.circular(20.0),
      //                                 bottomRight: Radius.circular(20.0),
      //                               ),
      //                               child: Image.network(
      //                                   "https://restaurant-api.dicoding.dev/images/medium/${detailRestaurant.detailRestaurantModel?.restaurant.pictureId}"),
      //                             ),
      //                             Row(
      //                               mainAxisAlignment:
      //                                   MainAxisAlignment.spaceBetween,
      //                               children: [
      //                                 Container(
      //                                   decoration: const BoxDecoration(
      //                                       color: secondaryColor),
      //                                   child: IconButton(
      //                                     onPressed: () {
      //                                       Navigator.pop(context);
      //                                     },
      //                                     icon: const Icon(
      //                                       Icons.arrow_back,
      //                                       color: primaryColor,
      //                                       size: 30,
      //                                     ),
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           ],
      //                         ),
      //                         const SizedBox(height: 12.0),
      //                         Container(
      //                           padding: const EdgeInsets.symmetric(
      //                               horizontal: 12.0),
      //                           child: Column(
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             children: [
      //                               Row(
      //                                 children: [
      //                                   Expanded(
      //                                     child: Text(
      //                                       detailRestaurant
      //                                               .detailRestaurantModel
      //                                               ?.restaurant
      //                                               .name ??
      //                                           "Resto Name",
      //                                       style: myTextTheme.displaySmall!
      //                                           .copyWith(fontSize: 36),
      //                                     ),
      //                                   ),
      //                                   const Icon(
      //                                     Icons.star_rounded,
      //                                     color: primaryColor,
      //                                     size: 30,
      //                                   ),
      //                                   const SizedBox(width: 4.0),
      //                                   Text(
      //                                     detailRestaurant.detailRestaurantModel
      //                                             ?.restaurant.rating
      //                                             .toString() ??
      //                                         "Rating",
      //                                     style: myTextTheme.headline5!
      //                                         .copyWith(
      //                                             fontWeight: FontWeight.bold),
      //                                   ),
      //                                 ],
      //                               ),
      //                               const SizedBox(height: 12.0),
      //                               Row(
      //                                 children: [
      //                                   const Icon(
      //                                     Icons.location_on_outlined,
      //                                     color: primaryColor,
      //                                     size: 30,
      //                                   ),
      //                                   const SizedBox(width: 8),
      //                                   Column(
      //                                     crossAxisAlignment:
      //                                         CrossAxisAlignment.start,
      //                                     children: [
      //                                       Text(
      //                                         detailRestaurant
      //                                                 .detailRestaurantModel
      //                                                 ?.restaurant
      //                                                 .address ??
      //                                             "City Resto",
      //                                         style: myTextTheme.bodyLarge!
      //                                             .copyWith(fontSize: 16.0),
      //                                       ),
      //                                       const SizedBox(height: 8),
      //                                       Text(
      //                                         detailRestaurant
      //                                                 .detailRestaurantModel
      //                                                 ?.restaurant
      //                                                 .city ??
      //                                             "City Resto",
      //                                         style: myTextTheme.bodyLarge!
      //                                             .copyWith(fontSize: 16.0),
      //                                       ),
      //                                     ],
      //                                   ),
      //                                 ],
      //                               ),
      //                               const SizedBox(height: 24.0),
      //                               SizedBox(
      //                                 height: 50,
      //                                 child: ListView.builder(
      //                                   scrollDirection: Axis.horizontal,
      //                                   itemCount: detailRestaurant
      //                                       .detailRestaurantModel!
      //                                       .restaurant
      //                                       .categories
      //                                       .length,
      //                                   itemBuilder: (context, index) =>
      //                                       Padding(
      //                                     padding: const EdgeInsets.symmetric(
      //                                         horizontal: 8.0),
      //                                     child: Chip(
      //                                       padding: const EdgeInsets.all(10),
      //                                       backgroundColor: primaryColor,
      //                                       label: Text(
      //                                         detailRestaurant
      //                                             .detailRestaurantModel!
      //                                             .restaurant
      //                                             .categories[index]
      //                                             .name,
      //                                         style: const TextStyle(
      //                                             color: whiteColor),
      //                                       ),
      //                                     ),
      //                                   ),
      //                                 ),
      //                               ),
      //                               const SizedBox(height: 24.0),
      //                               Text(
      //                                 detailRestaurant.detailRestaurantModel
      //                                         ?.restaurant.description ??
      //                                     "decs",
      //                                 textAlign: TextAlign.justify,
      //                                 style: myTextTheme.bodyText1,
      //                               ),
      //                               const SizedBox(height: 18.0),
      //                               // MAKANAN
      //                               Text(
      //                                 "Makanan",
      //                                 style: myTextTheme.headline6,
      //                               ),
      //                               SizedBox(
      //                                 height: 150,
      //                                 child: ListView.builder(
      //                                   itemCount: detailRestaurant
      //                                       .detailRestaurantModel!
      //                                       .restaurant
      //                                       .menus
      //                                       .foods
      //                                       .length,
      //                                   scrollDirection: Axis.horizontal,
      //                                   itemBuilder: (context, index) {
      //                                     return Padding(
      //                                       padding: const EdgeInsets.all(8.0),
      //                                       child: Container(
      //                                         width: 150,
      //                                         decoration: BoxDecoration(
      //                                           color: Colors.grey[350],
      //                                           borderRadius:
      //                                               BorderRadius.circular(20),
      //                                         ),
      //                                         child: Center(
      //                                           child: Column(
      //                                             children: [
      //                                               const SizedBox(height: 20),
      //                                               const FlutterLogo(
      //                                                   size: 60.0),
      //                                               const SizedBox(height: 20),
      //                                               Text(detailRestaurant
      //                                                   .detailRestaurantModel!
      //                                                   .restaurant
      //                                                   .menus
      //                                                   .foods[index]
      //                                                   .name)
      //                                             ],
      //                                           ),
      //                                         ),
      //                                       ),
      //                                     );
      //                                   },
      //                                 ),
      //                               ),
      //                               const SizedBox(height: 18.0),
      //                               Text(
      //                                 "Minuman",
      //                                 style: myTextTheme.headline6,
      //                               ),
      //                               // MINUMAN
      //                               SizedBox(
      //                                 height: 150,
      //                                 child: ListView.builder(
      //                                   itemCount: detailRestaurant
      //                                       .detailRestaurantModel!
      //                                       .restaurant
      //                                       .menus
      //                                       .drinks
      //                                       .length,
      //                                   scrollDirection: Axis.horizontal,
      //                                   itemBuilder: (context, index) {
      //                                     return Padding(
      //                                       padding: const EdgeInsets.all(8.0),
      //                                       child: Container(
      //                                         width: 150,
      //                                         decoration: BoxDecoration(
      //                                           color: Colors.grey[350],
      //                                           borderRadius:
      //                                               BorderRadius.circular(20),
      //                                         ),
      //                                         child: Center(
      //                                           child: Column(
      //                                             children: [
      //                                               const SizedBox(height: 20),
      //                                               const FlutterLogo(
      //                                                   size: 60.0),
      //                                               const SizedBox(height: 20),
      //                                               Text(detailRestaurant
      //                                                   .detailRestaurantModel!
      //                                                   .restaurant
      //                                                   .menus
      //                                                   .drinks[index]
      //                                                   .name),
      //                                             ],
      //                                           ),
      //                                         ),
      //                                       ),
      //                                     );
      //                                   },
      //                                 ),
      //                               ),
      //                               const SizedBox(height: 12.0),
      //                               Text(
      //                                 "Reviews",
      //                                 style: myTextTheme.headline6,
      //                               ),
      //                               // REVIEW
      //                               SizedBox(
      //                                 height: 130,
      //                                 child: ListView.builder(
      //                                   itemCount: detailRestaurant
      //                                       .detailRestaurantModel!
      //                                       .restaurant
      //                                       .customerReviews
      //                                       .length,
      //                                   scrollDirection: Axis.horizontal,
      //                                   itemBuilder: (context, index) {
      //                                     return Padding(
      //                                       padding: const EdgeInsets.all(8.0),
      //                                       child: Container(
      //                                         width: 300,
      //                                         decoration: BoxDecoration(
      //                                           color: Colors.grey[300],
      //                                           borderRadius:
      //                                               BorderRadius.circular(20),
      //                                         ),
      //                                         child: Padding(
      //                                           padding:
      //                                               const EdgeInsets.all(12.0),
      //                                           child: Column(
      //                                             crossAxisAlignment:
      //                                                 CrossAxisAlignment.start,
      //                                             children: [
      //                                               Text(
      //                                                 "Nama : ${detailRestaurant.detailRestaurantModel!.restaurant.customerReviews[index].name}",
      //                                                 style:
      //                                                     myTextTheme.bodyLarge,
      //                                               ),
      //                                               Text(
      //                                                   "Tanggal: ${detailRestaurant.detailRestaurantModel!.restaurant.customerReviews[index].date}"),
      //                                               Expanded(
      //                                                 child: Text(
      //                                                   detailRestaurant
      //                                                       .detailRestaurantModel!
      //                                                       .restaurant
      //                                                       .customerReviews[
      //                                                           index]
      //                                                       .review,
      //                                                 ),
      //                                               ),
      //                                             ],
      //                                           ),
      //                                         ),
      //                                       ),
      //                                     );
      //                                   },
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //             ],
      //           ),
      //         ),
      //       );
      //     } else if (detailRestaurant.state == ResultState.noData) {
      //       return const Center(child: Text("Gagal terhubung"));
      //     } else if (detailRestaurant.state == ResultState.error) {
      //       return const Text("Error");
      //     } else {
      //       return const Text("Kosong");
      //     }
      //   },
      // ),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ReviewPage(idRestaurant: widget.idResto),
                    ),
                  ).then((value) {
                    setState(() {});
                  });
                },
                child: Text(
                  "REVIEW RESTAURANT",
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
                    const Expanded(
                      child: Icon(
                        Icons.add,
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(
                        width: 12,
                      ),
                    ),
                    Expanded(
                        flex: 5,
                        child: Text("RESERVASI", style: myTextTheme.button)),
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
