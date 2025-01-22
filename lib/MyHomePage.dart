import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'apifile.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  // Fetch current weather
  Future<Map<String, dynamic>> getCurrentWeather(String cityName) async {
    var url = Uri.parse(
        "http://api.openweathermap.org/data/2.5/weather?q=$cityName,ind&APPID=${Config.apiKey}");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load weather data");
    }
  }

  // Fetch weather forecast
  Future<Map<String, dynamic>> getWeatherForecast(String cityName) async {
    var url = Uri.parse(
        "http://api.openweathermap.org/data/2.5/forecast?q=$cityName,ind&APPID=${Config.apiKey}");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load forecast data");
    }
  }

  @override
  Widget build(BuildContext context) {
    const String cityName = "Delhi";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              // Refresh the data
              getCurrentWeather(cityName);
              getWeatherForecast(cityName);
            }
            ),
            ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // FutureBuilder for Current Weather
              FutureBuilder<Map<String, dynamic>>(
                future: getCurrentWeather(cityName),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    return CurrentWeatherCard(weatherData: snapshot.data!);
                  }
                  else {
                    return const Text("No data available");
                  }
                },
              ),
              const SizedBox(height: 25),

              // FutureBuilder for Weather Forecast
              FutureBuilder<Map<String, dynamic>>(
                future: getWeatherForecast(cityName),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    return WeatherForecastSection(weatherForecast: snapshot.data!);
                  } else {
                    return const Text("No data available");
                  }
                },
              ),
              const SizedBox(height: 25),
              FutureBuilder<Map<String, dynamic>>(
                future: getCurrentWeather(cityName),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    return AdditionalInfoSection(currentWeather: snapshot.data!);
                  } else {
                    return const Text("No data available");
                  }
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}


String getWeatherIconUrl(String iconCode) {
  return "https://openweathermap.org/img/wn/$iconCode@2x.png";
}

class CurrentWeatherCard extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const CurrentWeatherCard({super.key, required this.weatherData});

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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${weatherData['name']}, ${weatherData['sys']['country']}",
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 25),
                  Image.network(
                    getWeatherIconUrl(weatherData['weather'][0]['icon']),
                    height: 80,
                    width: 80,
                  ),
                  const SizedBox(height: 25),
                  Text(
                    "${(weatherData['main']['temp'] - 273.15).toStringAsFixed(2)} °C",
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
  final Map<String, dynamic> weatherForecast;

  const WeatherForecastSection({super.key, required this.weatherForecast});

  @override
  Widget build(BuildContext context) {
    if (weatherForecast["list"] == null) {
      return const Text("Weather forecast data not available.",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Weather Forecast",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var forecast in weatherForecast["list"])
                _WeatherForecastCard(
                  time: forecast["dt_txt"].toString().substring(11, 16),
                  weather: forecast["weather"][0]["main"],
                  iconUrl: getWeatherIconUrl(forecast["weather"][0]["icon"]),
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
  final String iconUrl;

  const _WeatherForecastCard({
    required this.time,
    required this.weather,
    required this.iconUrl,
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
                Image.network(iconUrl, height: 50, width: 50),
                const SizedBox(height: 12),
                Text(
                  weather,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Displays additional weather details like wind speed, visibility, and humidity.
class AdditionalInfoSection extends StatelessWidget {
  final Map<String, dynamic> currentWeather;

  const AdditionalInfoSection({super.key, required this.currentWeather});

  @override
  Widget build(BuildContext context) {
    // Extracts data with null safety
    final windSpeed = currentWeather['wind']?['speed']?.toString() ?? 'No data';
    final visibility = currentWeather['visibility']?.toString() ?? 'No data';
    final humidity = currentWeather['main']?['humidity']?.toString() ?? 'No data';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Additional Information",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _InfoColumn(
                icon: Icons.waves,
                title: "Wind Speed",
                value: windSpeed,
              ),
              _InfoColumn(
                icon: Icons.visibility,
                title: "Visibility",
                value: visibility,
              ),
              _InfoColumn(
                icon: Icons.water_drop,
                title: "Humidity",
                value: humidity,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Represents a single column of additional weather information.
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
              fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}