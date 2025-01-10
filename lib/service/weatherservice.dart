import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_weather_app/weathermodel/weathermodel.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = "https://openweathermap.org/";
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=33.44&lon=-94.04&appid=1737bfeb9717db8a4ec2687bcd95c6e1'));

    var c = 8;
    log(c);
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load weather data");
    }
  }

  Future<String> getCurrentCity() async {
    var c = 9;
    log(c);
    return "asd";
    //get permission
    //LocationPermission permission = await Geolocator.checkPermission();
    //if (permission == LocationPermission.denied) {
      //permission = await Geolocator.checkPermission();
    //}

    //fetch the current location
    Position position = await Geolocator.getCurrentPosition(
        //desiredAccuracy: LocationAccuracy.high;
        );

    //convert the location into a list of place-mark objects
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    //extract the city name from the first place-mark

    String? city = placemarks[0].locality;

    return city ?? "";
  }
}
