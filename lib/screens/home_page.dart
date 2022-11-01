import 'package:dicoding_restaurant_app/common/internet_not_connected.dart';
import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/data/provider/restaurant_provider.dart';
import 'package:dicoding_restaurant_app/screens/favorite_restaurant_page.dart';
import 'package:dicoding_restaurant_app/screens/search_restaurant_page.dart';
import 'package:dicoding_restaurant_app/screens/setting_page.dart';
import 'package:dicoding_restaurant_app/widgets/card_list_widget.dart';
import 'package:dicoding_restaurant_app/widgets/title_home_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import '../utils/result_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ListRestaurantProvider>(context, listen: false).getList();
    });

    _widgetOptions;
  }

  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = const <Widget>[
    HomeScreen(),
    FavoritePage(),
    SettingPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // header
          Stack(
            children: [
              Container(
                height: 150.0,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: secondaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const TitleHomePage(),
                    const SizedBox(height: 30),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(),
                      ),
                      child: Form(
                        child: TextFormField(
                          readOnly: true,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const SearchRestaurantPage();
                              },
                            ),
                          ),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.search_outlined,
                              color: primaryColor,
                            ),
                            border: InputBorder.none,
                            hintText: "Search",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Visibility(
            visible: Provider.of<InternetConnectionStatus>(context) ==
                InternetConnectionStatus.disconnected,
            child: const InternetNotAvailable(),
          ),
          Provider.of<InternetConnectionStatus>(context) ==
                  InternetConnectionStatus.disconnected
              ? const Text("check your internet!")
              : Expanded(
                  child: Consumer<ListRestaurantProvider>(
                    builder: (context,
                        ListRestaurantProvider dataListRestaurant, _) {
                      if (dataListRestaurant.state == ResultState.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (dataListRestaurant.state ==
                          ResultState.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: dataListRestaurant.result.length,
                          itemBuilder: (context, index) {
                            return CardListWidget(
                                restaurant: dataListRestaurant.result[index]);
                          },
                        );
                      } else if (dataListRestaurant.state ==
                          ResultState.noData) {
                        return const Center(
                          child: Text("Gagal mengambil data"),
                        );
                      } else if (dataListRestaurant.state ==
                          ResultState.error) {
                        return const Center(
                          child: Text("Error"),
                        );
                      } else {
                        return const Center(
                          child: Text("Kosong"),
                        );
                      }
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
