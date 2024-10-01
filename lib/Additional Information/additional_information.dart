import 'dart:ui';
import 'package:flutter/material.dart';

class AdditionalInfo extends StatelessWidget {
  final IconData? icon;
  final String? typeOfInfo;
  final dynamic data;
  final String? unit;

  const AdditionalInfo({
    super.key,
    this.icon,
    this.typeOfInfo,
    this.data,
    this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: const Color.fromARGB(255, 44, 44, 44),
      elevation: 10,
      // ClipRRect and BackDropFilter goes inside the Card Widget
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: SizedBox(
            height: 110,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    verticalDirection: VerticalDirection.down,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10),
                      Icon(
                        icon,
                        color: const Color.fromARGB(255, 182, 182, 182),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        typeOfInfo.toString(),
                        style: const TextStyle(
                          color: Color.fromARGB(255, 182, 182, 182),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 130),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      unit.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
