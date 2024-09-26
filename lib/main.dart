import 'package:flutter/material.dart';
import 'dart:math'; // For generating random numbers

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  String cityName = '';
  String temperature = '--';
  String weatherCondition = '--';

  TextEditingController cityController = TextEditingController();


  void fetchWeatherData(String city) {
    Random random = Random();


    int temp = 15 + random.nextInt(16);

    List<String> conditions = ['Sunny', 'Cloudy', 'Rainy'];
    String condition = conditions[random.nextInt(conditions.length)];


    setState(() {
      cityName = city;
      temperature = '$temp°C';
      weatherCondition = condition;
    });
  }


  void onFetchWeather() {
    String city = cityController.text;
    if (city.isNotEmpty) {
      fetchWeatherData(city);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: 'Enter City Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onFetchWeather,
              child: Text('Fetch Weather'),
            ),
            SizedBox(height: 20),

            Text(
              'City: $cityName',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),

            Text(
              'Temperature: $temperature',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),

            Text(
              'Condition: $weatherCondition',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}