import 'dart:ui';
import 'package:flutter/material.dart';
import 'additional_info_item.dart';
import 'hourely_forecast_item.dart';
import 'package:http/http.dart' as http;



class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  Future getCurrentWeather() async {


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              // TODO: Implement refresh functionality
              debugPrint("Refresh pressed");
            },
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              CurrentWeatherCard(),
              SizedBox(height: 25),
              WeatherForecastSection(),
              SizedBox(height: 25),
              AdditionalInfoSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class CurrentWeatherCard extends StatelessWidget {
  const CurrentWeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Temperature",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 25),
                  Icon(
                    Icons.cloud,
                    size: 60,
                  ),
                  SizedBox(height: 25),
                  Text(
                    "Cloudy",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WeatherForecastSection extends StatelessWidget {
  const WeatherForecastSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Weather Forecast",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _WeatherForecastCard(
                time: "01:00 AM",
                weather: "Cloudy",
                icon: Icons.cloud,
              ),
              _WeatherForecastCard(
                time: "03:00 AM",
                weather: "Sunny",
                icon: Icons.wb_sunny,
              ),
              _WeatherForecastCard(
                time: "05:00 AM",
                weather: "Rainy",
                icon: Icons.beach_access,
              ),
              _WeatherForecastCard(
                time: "07:00 AM",
                weather: "Snowy",
                icon: Icons.ac_unit,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WeatherForecastCard extends StatelessWidget {
  final String time;
  final String weather;
  final IconData icon;

  const _WeatherForecastCard({
    required this.time,
    required this.weather,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, left: 8.0),
      child: SizedBox(
        width: 150,
        child: Card(
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Icon(
                  icon,
                  size: 36,
                ),
                const SizedBox(height: 12),
                Text(
                  weather,
                  style: const TextStyle(
                    fontSize: 18,
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

class AdditionalInfoSection extends StatelessWidget {
  const AdditionalInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Additional Information",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _InfoColumn(
                icon: Icons.water_drop,
                title: "Humidity",
                value: "50%",
              ),
              _InfoColumn(
                icon: Icons.waves,
                title: "Wind Speed",
                value: "5 km/h",
              ),
              _InfoColumn(
                icon: Icons.visibility,
                title: "Visibility",
                value: "10 km",
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoColumn extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoColumn({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 35),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}