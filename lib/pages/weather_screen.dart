import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/Hourly%20Information/hourly_information.dart';
import 'package:weather_app/Additional%20Information/additional_information.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/Private/private_information.dart';
import '../Effects/refresh_shimmer_effect.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final currentDay = DateFormat("EEEE").format(DateTime.now());
  late Future<Map<String, dynamic>> weather;

  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
    initializeDateFormat();
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = "Mumbai";
      final response = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey",
        ),
      );
      final result = jsonDecode(response.body);

      debugPrint(result["cod"]);

      if (result["cod"] != "200") {
        throw "An unexpected error occured";
      }

      //result["list"][0]["main"]["temp"] - 273;

      return result;
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  Future<void> initializeDateFormat() async {
    await initializeDateFormatting('en_IN', null);
    setState(() {});
  }

  void _refresh() {
    setState(() {
      weather = getCurrentWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _refresh,
            icon: const Icon(Icons.refresh_sharp),
            color: const Color.fromARGB(255, 147, 145, 145),
            enableFeedback: true,
            tooltip: "Refresh",
          ),
        ],
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 33, 32, 32),
      ),
      backgroundColor: const Color.fromARGB(255, 33, 32, 32),
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ShimmerEffect();
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }
          final data = snapshot.data!;
          final currentWeatherData = data["list"][0];
          final double currentTemp = currentWeatherData["main"]["temp"] - 273;
          final currentSkydata = currentWeatherData["weather"][0]["main"];
          final currentPressure = currentWeatherData["main"]["pressure"];
          final currentHumidity = currentWeatherData["main"]["humidity"];
          final currentWindSpeed = currentWeatherData["wind"]["speed"];
          return SingleChildScrollView(
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
                        child: SizedBox(
                          height: 250,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                currentDay,
                                style: const TextStyle(
                                  fontSize: 27,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Icon(
                                  currentSkydata == "Rain" ||
                                          currentSkydata == "Clear"
                                      ? Icons.cloudy_snowing
                                      : Icons.sunny,
                                  color: currentSkydata == "Rain" ||
                                          currentSkydata == "Clear"
                                      ? Colors.white
                                      : Colors.yellow,
                                  size: 90,
                                ),
                              ),
                              Text(
                                "${currentTemp.toStringAsFixed(0)}°C",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 42,
                                ),
                              ),
                            ],
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
                          "Hourly Forecast",
                          style: TextStyle(
                            inherit: true,
                            fontWeight: FontWeight.w700,
                            fontSize: 23,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 210,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        final dateTime = data["list"][index + 1]["dt_txt"];
                        final hourlyTempForecast =
                            data["list"][index + 1]["main"]["temp"];
                        final horlySkyDataForecast =
                            data["list"][index + 1]["weather"][0]["main"];
                        return HourlyWeather(
                          date: DateFormat.E().format(
                            DateTime.parse(dateTime),
                          ),
                          time: DateFormat.j().format(
                            DateTime.parse(dateTime),
                          ),
                          icon: horlySkyDataForecast == "Rain" ||
                                  horlySkyDataForecast == "Clear"
                              ? Icons.cloudy_snowing
                              : Icons.sunny,
                          iconColor: horlySkyDataForecast == "Rain" ||
                                  horlySkyDataForecast == "Clear"
                              ? Colors.white
                              : Colors.yellow,
                          temperature: hourlyTempForecast.toInt() - 273,
                        );
                      },
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
                  Column(
                    verticalDirection: VerticalDirection.down,
                    children: [
                      AdditionalInfo(
                        icon: Icons.air_sharp,
                        typeOfInfo: "Wind Speed",
                        data: currentWindSpeed,
                        unit: "km/hr",
                      ),
                      AdditionalInfo(
                        icon: Icons.beach_access_sharp,
                        typeOfInfo: "Pressure",
                        data: currentPressure,
                        unit: "Pa",
                      ),
                      AdditionalInfo(
                        icon: Icons.water_drop_sharp,
                        typeOfInfo: "Humidity",
                        data: currentHumidity,
                        unit: "%",
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
