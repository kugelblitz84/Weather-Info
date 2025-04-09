// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:weather_app1/models/weather_models.dart';
// import 'package:weather_app1/weather_service.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:flutter_animate/flutter_animate.dart';

// class WeatherHome extends StatefulWidget {
//   const WeatherHome({super.key});

//   @override
//   State<WeatherHome> createState() => _WeatherHomeState();
// }

// class _WeatherHomeState extends State<WeatherHome> {
//   late WeatherData weatherInfo;
//   bool Loaded = false;
//   late double longitude; // 90.3877;
//   late double latitude; //23.9905;
//   setmyWeather() {
//     //Loaded = false;
//     WeatherServices().fetchWeather(longitude, latitude).then((value) {
//       setState(() {
//         weatherInfo = value;
//         Loaded = true;
//       });
//     });
//   }

//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled, show an error message
//       print('Location services are disabled.');
//       return;
//     }

//     // Request location permission
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         print('Location permissions are denied.');
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       print('Location permissions are permanently denied.');
//       return;
//     }

//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//         //'desiredAccuracy' is deprecated and shouldn't be used. use settings parameter with AndroidSettings, AppleSettings, WebSettings, or LocationSettings.
// //Try replacing the use of the deprecated member with the replacement.

//     setState(() {
//       latitude = position.latitude;
//       longitude = position.longitude;
//     });
//     setmyWeather();
//   }

//   @override
//   void initState() {
//     weatherInfo = WeatherData(
//       name: '',
//       temperature: Temperature(current: 0.0),
//       humidity: 0,
//       wind: Wind(speed: 0.0),
//       maxTemperature: 0,
//       minTemperature: 0,
//       pressure: 0,
//       seaLevel: 0,
//       weather: [],
//     );
//     _getCurrentLocation();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     String formattedDate =
//         DateFormat('EEEE d, MMMM yyyy').format(DateTime.now());
//     String formattedTime = DateFormat('hh:mm a').format(DateTime.now());
//     return Scaffold(
//       backgroundColor: const Color(0xFF676BD0),
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: Loaded
//                   ? WeatherDetail(
//                       weather: weatherInfo,
//                       formattedDate: formattedDate,
//                       formattedTime: formattedTime,
//                     )
//                   : const CircularProgressIndicator(
//                       color: Colors.white,
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class WeatherDetail extends StatelessWidget {
//   final WeatherData weather;
//   final String formattedDate;
//   final String formattedTime;
//   const WeatherDetail({
//     super.key,
//     required this.weather,
//     required this.formattedDate,
//     required this.formattedTime,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           weather.name,
//           style: const TextStyle(
//             fontSize: 25,
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         // for current temperature of my location
//         Text(
//           "${weather.temperature.current.toStringAsFixed(2)}°C",
//           style: const TextStyle(
//             fontSize: 40,
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         // fpr weather condition
//         if (weather.weather.isNotEmpty)
//           Text(
//             weather.weather[0].main,
//             style: const TextStyle(
//               fontSize: 20,
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         const SizedBox(height: 30),
//         // for current date and time
//         Text(
//           formattedDate,
//           style: const TextStyle(
//             fontSize: 18,
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text(
//           formattedTime,
//           style: const TextStyle(
//             fontSize: 18,
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 30),
//         Container(
//           height: 200,
//           width: 200,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("assets/cloudy.png"),
//             ),
//           ),
//         ),
//         const SizedBox(height: 30),
//         // for more weather detail
//         Container(
//           height: 250,
//           decoration: BoxDecoration(
//             color: Colors.deepPurple,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Icon(
//                           Icons.wind_power,
//                           color: Colors.white,
//                         ),
//                         const SizedBox(height: 5),
//                         weatherInfoCard(
//                             title: "Wind", value: "${weather.wind.speed}km/h"),
//                       ],
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Icon(
//                           Icons.sunny,
//                           color: Colors.white,
//                         ),
//                         const SizedBox(height: 5),
//                         weatherInfoCard(
//                             title: "Max",
//                             value:
//                                 "${weather.maxTemperature.toStringAsFixed(2)}°C"),
//                       ],
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Icon(
//                           Icons.wind_power,
//                           color: Colors.white,
//                         ),
//                         const SizedBox(height: 5),
//                         weatherInfoCard(
//                             title: "Min",
//                             value:
//                                 "${weather.minTemperature.toStringAsFixed(2)}°C"),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const Divider(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Icon(
//                           Icons.water_drop,
//                           color: Colors.amber,
//                         ),
//                         const SizedBox(height: 5),
//                         weatherInfoCard(
//                             title: "Humidity", value: "${weather.humidity}%"),
//                       ],
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Icon(
//                           Icons.air,
//                           color: Colors.amber,
//                         ),
//                         const SizedBox(height: 5),
//                         weatherInfoCard(
//                             title: "Pressure", value: "${weather.pressure}hPa"),
//                       ],
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Icon(
//                           Icons.leaderboard,
//                           color: Colors.amber,
//                         ),
//                         const SizedBox(height: 5),
//                         weatherInfoCard(
//                             title: "Sea-Level", value: "${weather.seaLevel}m"),
//                       ],
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Column weatherInfoCard({required String title, required String value}) {
//     return Column(
//       children: [
//         Text(
//           value,
//           style: const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.w700,
//             fontSize: 18,
//           ),
//         ),
//         Text(
//           title,
//           style: const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.w500,
//             fontSize: 16,
//           ),
//         )
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app1/models/weather_models.dart';
import 'package:weather_app1/weather_service.dart';
import 'package:lottie/lottie.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  late WeatherData weatherInfo;
  bool Loaded = false;
  late double longitude;
  late double latitude;

  setMyWeather() async {
    weatherInfo = await WeatherServices().fetchWeather(longitude, latitude);
    setState(() {
      Loaded = true;
    });
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied.');
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });

    setMyWeather();
  }

  @override
  void initState() {
    weatherInfo = WeatherData(
      name: '',
      temperature: Temperature(current: 0.0),
      humidity: 0,
      wind: Wind(speed: 0.0),
      maxTemperature: 0,
      minTemperature: 0,
      pressure: 0,
      seaLevel: 0,
      weather: [],
    );
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('EEEE d, MMMM yyyy').format(DateTime.now());
    String formattedTime = DateFormat('hh:mm a').format(DateTime.now());

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF232526), Color(0xFF414345)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Loaded
                ? WeatherDetail(
                    weather: weatherInfo,
                    formattedDate: formattedDate,
                    formattedTime: formattedTime,
                  )
                : const CircularProgressIndicator(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class WeatherDetail extends StatelessWidget {
  final WeatherData weather;
  final String formattedDate;
  final String formattedTime;

  const WeatherDetail({
    super.key,
    required this.weather,
    required this.formattedDate,
    required this.formattedTime,
  });

  String getWeatherAnimation(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return 'assets/sunny.json';
      case 'clouds':
        return 'assets/cloudy.json';
      case 'rain':
        return 'assets/rain.json';
      case 'snow':
        return 'assets/snow.json';
      case 'thunderstorm':
        return 'assets/rain_withthunder.json';
      case 'haze':
        return 'assets/haze.json';
      default:
        return 'assets/cloudy.json';
    }
  }

  Widget buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(color: Colors.white70, fontSize: 16)),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final condition =
        weather.weather.isNotEmpty ? weather.weather[0].main : 'Clear';

    return Animate(
      effects: const [FadeEffect(), SlideEffect()],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            weather.name,
            style: const TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 5),
          Text(formattedDate,
              style: const TextStyle(fontSize: 16, color: Colors.white70)),
          Text(formattedTime,
              style: const TextStyle(fontSize: 16, color: Colors.white70)),
          const SizedBox(height: 20),

          // Replace the GIF part with Lottie animation
          SizedBox(
            height: 180,
            child: Lottie.asset(
              getWeatherAnimation(condition),
              repeat: true,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 20),
          Text(
            "${weather.temperature.current.toStringAsFixed(1)}°C",
            style: const TextStyle(
                fontSize: 44, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            condition,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 25),

          // Glassmorphic Weather Info Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.32),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white30),
            ),
            child: Column(
              children: [
                buildInfoRow("Wind", "${weather.wind.speed} km/h"),
                buildInfoRow("Humidity", "${weather.humidity}%"),
                buildInfoRow("Pressure", "${weather.pressure} hPa"),
                buildInfoRow("Max Temp",
                    "${weather.maxTemperature.toStringAsFixed(1)}°C"),
                buildInfoRow("Min Temp",
                    "${weather.minTemperature.toStringAsFixed(1)}°C"),
                buildInfoRow("Sea Level", "${weather.seaLevel} m"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
