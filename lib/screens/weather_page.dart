import 'package:atmosphero/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherFactory _wf = WeatherFactory(APIKey);
  Weather? weather;

  @override
  void initState() {
    _wf.currentWeatherByCityName("Malappuram").then((w) {
      setState(() {
        weather = w; 
      });
    }); 
    super.initState(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 204, 202, 202),
      body: UIpart(),
    );
  }

  // ignore: non_constant_identifier_names
  Widget UIpart() {
    if (weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LocationHeader(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.08,
          ),
          DateTimeinfo(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
          ),
          WeatherIcon(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
          CurrentTemp(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
          Extrainfo()
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget LocationHeader() {
    return Text(
      weather?.areaName ?? "",
      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
    );
  }

  // ignore: non_constant_identifier_names
  Widget DateTimeinfo() {
    DateTime now = weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            Text(
              DateFormat("  ${DateFormat("d.m.y").format(now)}").format(now),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        )
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget WeatherIcon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.20,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "http://openweathermap.org/img/wn/${weather?.weatherIcon}@4x.png"))),
        ),
        Text(weather?.weatherDescription ?? "",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget CurrentTemp() {
    return Text("${weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
        style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w600));
  }

  // ignore: non_constant_identifier_names
  Widget Extrainfo() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.15,
      width: MediaQuery.sizeOf(context).width * 0.80,
      decoration: BoxDecoration(
          color: Colors.amber, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Max: ${weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              Text("Min: ${weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600))
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [ 
              Text("Wind: ${weather?.windSpeed?.toStringAsFixed(0)}m/s",
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              Text("Humidity: ${weather?.humidity?.toStringAsFixed(0)}%",
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600))
            ],
          )
        ],
      ),
    );
  }
}
