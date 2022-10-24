import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/data/provider/detail_restaurant_provider.dart';
import 'package:dicoding_restaurant_app/data/provider/restaurant_provider.dart';
import 'package:dicoding_restaurant_app/data/provider/search_restaurant_provider.dart';
import 'package:dicoding_restaurant_app/screens/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DetailRestaurantProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ListRestaurantProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchRestaurantProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Restaurant App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: myTextTheme,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
