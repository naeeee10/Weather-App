import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/Hourly%20Information/hourly_information.dart';
import 'package:weather_app/Additional%20Information/additional_information.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black54,
      highlightColor: Colors.black12,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Mumbai , India",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 23,
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(16),
                ),
                color: const Color.fromARGB(255, 44, 44, 44),
                elevation: 10,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Shimmer.fromColors(
                      baseColor: Colors.black54,
                      highlightColor: Colors.black12,
                      child: const SizedBox(
                        height: 250,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(10.0),
                child: const Column(
                  children: [
                    Text(
                      "Weather Forecast",
                      style: TextStyle(
                        inherit: true,
                        fontWeight: FontWeight.w700,
                        fontSize: 23,
                      ),
                    ),
                  ],
                ),
              ),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HourlyWeather(),
                    HourlyWeather(),
                    HourlyWeather(),
                    HourlyWeather(),
                    HourlyWeather(),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  "Additional Infomation",
                  style: TextStyle(
                    inherit: true,
                    fontWeight: FontWeight.w700,
                    fontSize: 23,
                  ),
                ),
              ),
              const Column(
                verticalDirection: VerticalDirection.down,
                children: [
                  AdditionalInfo(),
                  AdditionalInfo(),
                  AdditionalInfo(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
