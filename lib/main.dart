import 'package:flutter/material.dart';
import 'dart:math'; // For generating random numbers

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.green,
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
  String temperature = '';
  String weatherCondition = '';

  TextEditingController cityController = TextEditingController();

  List<Map<String, String>> weeklyForecast = [];


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

  void fetch7DayForecast(String city) {
    Random random = Random();
    List<String> conditions = ['Sunny', 'Cloudy', 'Rainy'];

    List<Map<String, String>> forecast = List.generate(7, (index) {
      int temp = 15 + random.nextInt(16);
      String condition = conditions[random.nextInt(conditions.length)];
      return {
        'day': 'Day ${index + 1}',
        'temperature': '$temp°C',
        'condition': condition,
      };
    });

    setState(() {
      cityName = city;
      weeklyForecast = forecast;
    });
  }



  void onFetch7DayForecast() {
    String city = cityController.text;
    if (city.isNotEmpty) {
      fetch7DayForecast(city);
    }
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
      body: SingleChildScrollView(
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
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: onFetch7DayForecast,
              child: Text('Fetch 7-Day Forecast'),
            ),
            SizedBox(height: 20),
            if (weeklyForecast.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '7-Day Forecast',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ...weeklyForecast.map((dayForecast) => ListTile(
                        title: Text(dayForecast['day']!),
                        subtitle: Text(
                            'Temperature: ${dayForecast['temperature']}, Condition: ${dayForecast['condition']}'),
                      )),
                ],
              ),
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