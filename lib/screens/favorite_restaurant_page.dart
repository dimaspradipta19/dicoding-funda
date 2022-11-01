import 'package:dicoding_restaurant_app/utils/result_state.dart';
import 'package:dicoding_restaurant_app/widgets/card_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/styles.dart';
import '../data/provider/database_provider.dart';

class FavoritePage extends StatelessWidget {
  static const String favoritesTitle = 'Favorites';
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: Text(
          "Favorite Restaurant",
          style: myTextTheme.bodyLarge!
              .copyWith(color: blackColor, fontSize: 22.0),
        ),
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, DatabaseProvider provider, child) {
          if (provider.state == ResultState.hasData) {
            return ListView.builder(
              itemCount: provider.favorites.length,
              itemBuilder: (context, index) {
                return CardListWidget(restaurant: provider.favorites[index]);
              },
            );
          } else {
            return Center(
              child: Material(
                child: Text(provider.message),
              ),
            );
          }
        },
      ),
    );
  }
}
