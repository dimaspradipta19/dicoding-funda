import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/data/provider/restaurant_provider.dart';
import 'package:dicoding_restaurant_app/screens/search_restaurant_page.dart';
import 'package:dicoding_restaurant_app/widgets/card_list_widget.dart';
import 'package:dicoding_restaurant_app/widgets/title_home_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                            onTap: () =>
                                Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const SearchRestaurantPage();
                              },
                            )),
                            decoration: const InputDecoration(

                              prefixIcon: Icon(Icons.search_outlined, color: primaryColor,),
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
            Expanded(
              child: Consumer<ListRestaurantProvider>(
                builder:
                    (context, ListRestaurantProvider dataListRestaurant, _) {
                  if (dataListRestaurant.state == ResultState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (dataListRestaurant.state == ResultState.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: dataListRestaurant.result.length,
                      itemBuilder: (context, index) {
                        final listRestaurant = dataListRestaurant.result[index];
                        return CardListWidget(restaurant: listRestaurant);
                      },
                    );
                  } else if (dataListRestaurant.state == ResultState.noData) {
                    return const Center(
                      child: Text("dataListRestaurant.message"),
                    );
                  } else if (dataListRestaurant.state == ResultState.error) {
                    return const Center(
                      child: Text("dataListRestaurant.message"),
                    );
                  } else {
                    return const Center(
                      child: Text(""),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
