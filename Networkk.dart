import 'dart:convert';

import 'package:flutterr/weather_forecast/weather_forecast_model.dart';
import 'package:http/http.dart';

class Networkk{
  Future<WeatherForecast>getWeatherForecast(String cityName) async{
    var url = "https://api.openweathermap.org/data/2.5/forecast?q=" + cityName + "&appid=37a2e58b945595e527a083e1837d6ea9&units=metric";

    final response = await get(Uri.parse(url));

    if(response.statusCode == 200){

      return WeatherForecast.fromJson(json.decode(response.body));
    }
    else{
      throw Exception("Error");
    }

  }
}