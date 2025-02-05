import 'package:flutter/material.dart';
import 'package:flutter_weather_app/service/weatherservice.dart';
import 'package:lottie/lottie.dart';

import '../weathermodel/weathermodel.dart';

class Weatherpage extends StatefulWidget {
  const Weatherpage({super.key});

  @override
  State<Weatherpage> createState() => _WeatherpageState();
}

class _WeatherpageState extends State<Weatherpage> {

  //api key
  final _weatherService = WeatherService('1737bfeb9717db8a4ec2687bcd95c6e1');
  Weather? _weather;

  //fetch the weather
  _fetchWeather() async {
    //get the current city
    String cityName = await _weatherService.getCurrentCity();

    //get the current weather of the city

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    //any errors
    catch(e){
      print(e);
    }
  }

  //weather animations


  //init state

  @override
  void initState() {
    super.initState();
    //fetch weather on startup
    _fetchWeather();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(_weather?.cityName ?? "loading city.."),
            //animation
            Lottie.asset("assets/cloudy.json"),
            //temperature
            Text("${_weather?.temperature.round()} F'")
          ],
        ),
      ),
    );
  }
}
