import 'package:dicoding_restaurant_app/models/list_restaurant_model.dart';
import 'package:dicoding_restaurant_app/screens/detail_restaurant_page.dart';
import 'package:flutter/material.dart';
import '../common/styles.dart';

class CardListWidget extends StatefulWidget {
  const CardListWidget({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  State<CardListWidget> createState() => _CardListWidgetState();
}

class _CardListWidgetState extends State<CardListWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DetailRestaurant(id: widget.restaurant.id);
            },
          ),
        );
      },
      child: Material(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Card(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Image.network(
                    "https://restaurant-api.dicoding.dev/images/medium/${widget.restaurant.pictureId}",
                    width: 100,
                    height: 100,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Text(
                          widget.restaurant.name!,
                          style: myTextTheme.bodyLarge!.copyWith(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: primaryColor,
                            size: 20.0,
                          ),
                          Text(
                            widget.restaurant.city!,
                            style:
                                myTextTheme.bodyLarge!.copyWith(fontSize: 14.0),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: primaryColor,
                      ),
                      Text(
                        "${widget.restaurant.rating}/5",
                        style: myTextTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
