import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_app/const.dart';
import 'package:mood_app/widgets/slider_switcher.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        actions: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () {
                context.push('/datepicker');
              },
              child: const Icon(
                Icons.calendar_month,
                size: 30,
                color: grey2,
              ),
            ),
          )
        ],
        centerTitle: true,
        title: Text(
          "${now.day} ${months[now.month - 1]} ${now.hour.toString().padLeft(2, "0")}:${now.minute.toString().padLeft(2, "0")}",
          style: const TextStyle(fontWeight: FontWeight.bold, color: grey2),
        ),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SliderSwitcher(index: 1),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Спасибо что выбрали нас!',
              style: TextStyle(
                  fontSize: 40,
                  color: customBlack,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
