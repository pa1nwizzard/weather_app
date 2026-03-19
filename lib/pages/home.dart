import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/data/weather.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/widgets/styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DateTime dt;
  Weather weather = Weather();
  List<List<dynamic>> sortedWeather = [];

  @override
  void initState() {
    initialWeather();
    dt = DateTime.now();
    print(dt);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 0, 133, 181),
              Color.fromARGB(255, 0, 64, 87)
            ]
          )
        ),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 72),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    'Surgut',
                    style: GoogleFonts.josefinSans(textStyle: textWhiteStyle),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Center(
                    child: Text(
                      weather.degreesCelsius.isEmpty ? '' : '${weather.degreesCelsius[0][dt.hour].round()}°',
                      style: GoogleFonts.josefinSans(textStyle: textWhiteStyle, fontSize: 112),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 160),
                  child: Center(
                    child: Text(
                      weather.degreesCelsius.isEmpty ? '' : 'Макс.: ${sortedWeather[0][23].round()}°, мин.: ${sortedWeather[0][0].round()}°',
                      style: GoogleFonts.josefinSans(textStyle: textWhiteStyle, fontSize: 26),
                    ),
                  ),
                ),
              ],
            ),
            
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
            child: Container(
              height: 120,
              decoration: boxWhiteDecoration
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 0),
            child: Container(
              height: 800,
              decoration: boxWhiteDecoration
            ),
          ),
        ],
      ),
      ),
    );
  }

  Future<void> initialWeather() async {
    final apiService = ApiService();
    final apiWeather = await apiService.initializeAPI();
    setState(() {
      weather = apiWeather;
      sortedWeather = weather.degreesCelsius;
      for (int i = 0; i < sortedWeather.length; i++) {
        sortedWeather[i].sort();
      }
    });
  }
}