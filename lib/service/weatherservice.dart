import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_weather_app/weathermodel/weathermodel.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;


class WeatherService {
  static const BASE_URL = "https://openweathermap.org/";
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async{
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));

        if (response.statusCode == 200) {
          return Weather.fromJson(jsonDecode(response.body));
        } else {
          throw Exception("Failed to load weather data");
        }
  }

  Future<String> getCurrentCity() async{

    //get permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.checkPermission();
    }

    //fetch the current location
    Position position = await Geolocator.getCurrentPosition(
      //desiredAccuracy: LocationAccuracy.high;
    );

    //convert the location into a list of place-mark objects
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    //extract the city name from the first place-mark

    String? city = placemarks[0].locality;

    return city ?? "";

  }
}