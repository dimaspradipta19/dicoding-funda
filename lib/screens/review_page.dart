import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/data/provider/review_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key, required this.idRestaurant});

  final String idRestaurant;

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _namaController.dispose();
    _reviewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Review Restaurant",
          style: myTextTheme.bodyLarge!.copyWith(color: blackColor),
        ),
        backgroundColor: secondaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            Text(widget.idRestaurant),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _namaController,
                    decoration: const InputDecoration(hintText: "Nama"),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _reviewController,
                    decoration:
                        const InputDecoration(hintText: "Isi Reviewnya"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                reviewProvider.review(widget.idRestaurant, _namaController.text,
                    _reviewController.text);

                Navigator.pop(context);
              },
              child: const Text("Input Review"),
            ),
          ],
        ),
      ),
    );
  }
}
