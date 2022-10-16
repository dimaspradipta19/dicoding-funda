import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:flutter/cupertino.dart';
class TitleHomePage extends StatelessWidget {
  const TitleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Restaurant",
          style: myTextTheme.headline4,
        ),
        Text(
          "Discover and book the best restaurant",
          style: myTextTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
