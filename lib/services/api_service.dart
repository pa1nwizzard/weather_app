import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/data/weather.dart';

class ApiService {
  Future<Weather> initializeAPI() async {
    const url = 'https://api.open-meteo.com/v1/forecast?latitude=61.2576&longitude=73.4177&hourly=temperature_2m&timezone=auto&forecast_days=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    Weather weather = Weather();
    weather.dateTimes = weather.splitter(json['hourly']['time']);
    weather.degreesCelsius = weather.splitter(json['hourly']['temperature_2m']);
    return weather;
  }
}