import 'package:dicoding_restaurant_app/data/provider/restaurant_provider.dart';
import 'package:dicoding_restaurant_app/data/provider/search_restaurant_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/styles.dart';

class SearchRestaurantPage extends StatefulWidget {
  const SearchRestaurantPage({super.key});

  @override
  State<SearchRestaurantPage> createState() => _SearchRestaurantPageState();
}

class _SearchRestaurantPageState extends State<SearchRestaurantPage> {
  final TextEditingController _namaRestoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _namaRestoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataResto =
        Provider.of<SearchRestaurantProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(),
                ),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Tidak boleh kosong";
                      }
                      return null;
                    },
                    controller: _namaRestoController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search_outlined,
                        color: primaryColor,
                      ),
                      border: InputBorder.none,
                      hintText: "Search",
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Provider.of<SearchRestaurantProvider>(context,
                                    listen: false)
                                .getSearch(_namaRestoController.text);
                          }
                        },
                        icon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                flex: 5,
                child: Consumer<SearchRestaurantProvider>(
                  builder: (context, SearchRestaurantProvider searchResto,
                          child) =>
                      searchResto.state == ResultState.loading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : searchResto.state == ResultState.noData
                              ? const Center(
                                  child: Text("No Data Found"),
                                )
                              : ListView.builder(
                                  itemCount: searchResto.result.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Image.network(
                                              "https://restaurant-api.dicoding.dev/images/medium/${searchResto.result[index].pictureId}",
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  searchResto
                                                      .result[index].name,
                                                  style: myTextTheme.headline4,
                                                ),
                                                Text(
                                                    searchResto.result[index]
                                                        .description,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .local_dining_rounded,
                                                      size: 30,
                                                      color: primaryColor,
                                                    ),
                                                    Text(searchResto
                                                        .result[index].city),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.star_rounded,
                                                      size: 30,
                                                      color: primaryColor,
                                                    ),
                                                    Text(
                                                      searchResto
                                                          .result[index].rating
                                                          .toString(),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
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
