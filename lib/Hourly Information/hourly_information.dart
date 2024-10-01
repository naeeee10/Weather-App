import 'dart:ui';
import 'package:flutter/material.dart';

class HourlyWeather extends StatelessWidget {
  final String? date;
  final String? time;
  final int? temperature;
  final IconData? icon;
  final Color? iconColor;

  const HourlyWeather({
    super.key,
    this.time,
    this.icon,
    this.iconColor,
    this.temperature,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(16),
      ),
      color: const Color.fromARGB(255, 44, 44, 44),
      elevation: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: SizedBox(
            height: 190,
            width: 170,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                Text(
                  time.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 30,
                  ),
                ),
                Text(
                  "$temperature°C",
                  style: const TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w700,
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
