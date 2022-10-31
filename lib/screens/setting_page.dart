import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/data/provider/scheduling_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: Text(
          "Setting Page",
          style: myTextTheme.bodyLarge!
              .copyWith(color: blackColor, fontSize: 22.0),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Scheduling Restaurant Menu"),
            trailing: Consumer<SchedulingProvider>(
              builder: (context, SchedulingProvider scheduled, _) =>
                  Switch.adaptive(
                value: scheduled.isScheduled,
                onChanged: (value) async {
                  scheduled.scheduledNews(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
