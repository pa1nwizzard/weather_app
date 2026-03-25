import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/data/weather.dart';
import 'package:weather_app/data/weekdays.dart';
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
                      weather.degreesCelsius.isEmpty ? '' : 'Max.: ${sortedWeather[0][23].round()}°, min.: ${sortedWeather[0][0].round()}°',
                      style: GoogleFonts.josefinSans(textStyle: textWhiteStyle, fontSize: 28),
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
              decoration: boxWhiteDecoration,
              child: Scaffold(
                backgroundColor: Color.fromARGB(0, 0, 0, 0),
                appBar: AppBar(
                  title: Column(
                    spacing: 2,
                    children: [
                      Text(
                        'Hourly forecast',
                        style: GoogleFonts.josefinSans(
                          fontSize: 24,
                          textStyle: TextStyle(color: Colors.white)
                        ),
                      ),
                      Container(
                        width: 1000,
                        height: 2,
                        color: Colors.white,
                      )
                    ],
                  ),
                  centerTitle: true,
                  backgroundColor: Color.fromARGB(0, 0, 0, 0),
                ),
                body: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 24,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 12, right: 8),
                      child: Column(
                        children: [
                          Text(
                            '$index',
                            style: GoogleFonts.josefinSans(
                              fontSize: 16,
                              textStyle: TextStyle(color: Colors.white)
                            )
                          ),
                          Text(
                            weather.degreesCelsius.isEmpty ? '' : '${weather.degreesCelsius[0][index].round()}°',
                            style: GoogleFonts.josefinSans(
                              fontSize: 16,
                              textStyle: TextStyle(color: Color.fromARGB(255, 0, 127, 173))
                            )
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 0),
            child: Container(
              height: 510,
              decoration: boxWhiteDecoration,
              child: Scaffold(
                backgroundColor: Color.fromARGB(0, 0, 0, 0),
                appBar: AppBar(
                  title: Column(
                    spacing: 2,
                    children: [
                      Text(
                        'Forecast for 10 days',
                        style: GoogleFonts.josefinSans(
                          fontSize: 24,
                          textStyle: TextStyle(color: Colors.white)
                        ),
                      ),
                      Container(
                        width: 1000,
                        height: 2,
                        color: Colors.white,
                      )
                    ],
                  ),
                  centerTitle: true,
                  backgroundColor: Color.fromARGB(0, 0, 0, 0),
                ),
                body: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsetsGeometry.only(top: 8, bottom: 8, right: 16, left: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            index == 0 ? 'Today' : '${dt.weekday + index <= 7 ? weekdays[dt.weekday + index] : weekdays[dt.weekday + index - 7]}',
                            style: GoogleFonts.josefinSans(
                              fontSize: 20,
                              textStyle: TextStyle(color: Colors.white)
                            ),
                          ),
                          Row(
                            spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 27,
                                child: Center(
                                  child: Text(
                                    weather.degreesCelsius.isEmpty ? '' : '${sortedWeather[index][0].round()}°',
                                    style: GoogleFonts.josefinSans(
                                      fontSize: 20,
                                      textStyle: TextStyle(color: Color.fromARGB(255, 0, 127, 173))
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 50,
                                child: Center(
                                  child: Container(
                                    width: 43,
                                    height: 1,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 27,
                                child: Center(
                                  child: Text(
                                    weather.degreesCelsius.isEmpty ? '' : '${sortedWeather[index][23].round()}°',
                                    style: GoogleFonts.josefinSans(
                                      fontSize: 20,
                                      textStyle: TextStyle(color: Color.fromARGB(255, 0, 127, 173))
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
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