import 'dart:ui';

import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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
              print("Refresh");
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Main Card
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 15,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10,
                      sigmaY: 10,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Temperature",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 25),
                          const Icon(
                            Icons.cloud,
                            size: 60,
                          ),
                          const SizedBox(height: 25),
                          const Text(
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
            ),
            const SizedBox(height: 25),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Weather Forecast",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Row with repeating cards
            SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Allows horizontal scrolling
              child: Row(
                children: [
                  for (int i = 0; i < 5; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: SizedBox(
                        width: 150, // Increased width for the cards
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Card(
                            elevation: 15,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0), // Increased padding inside the card
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "Time",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  const Icon(
                                    Icons.cloud,
                                    size: 36,
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    "Cloudy",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
