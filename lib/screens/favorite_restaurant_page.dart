import 'package:flutter/material.dart';

import '../common/styles.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: Text(
          "Favorite Restaurant",
          style: myTextTheme.bodyLarge!.copyWith(color: blackColor, fontSize: 22.0),
        ),
      ),
    );
  }
}
