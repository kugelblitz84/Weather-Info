import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app1/models/weather_models.dart';

class WeatherServices {

  fetchWeather(double? longitude, double? latitude) async {
    final response = await http.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=cad73040c837264efe5b07d7578d5ff9"),
    );
    try {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        print("response from the web:  ${response.body}");
        return WeatherData.fromJson(json);
      } else {
        throw Exception('Failed to load Weather data');
      }
    } catch (e) {
      print(e.toString());
    }
  }
  
}


// import http.client

// conn = http.client.HTTPSConnection("api.tripstins.com")

// payload = "{\n  \"email\": \"user@example.com\",\n  \"password\": \"string\"\n}"

// headers = {
//     'Content-Type': "application/json",
//     'Accept': "application/json",
//     'Authorization': "Bearer 123"
// }

// conn.request("POST", "/api/v1/login", payload, headers)

// res = conn.getresponse()
// data = res.read()

// print(data.decode("utf-8"))