import 'package:http/http.dart' as http;

import 'package:weather_forecast/src/tools/constants.dart';
import 'package:weather_forecast/src/tools/custom_app_exception.dart';
import 'package:weather_forecast/src/models/data/weather_model.dart';

class WeatherProvider{
  Future<Map<String,dynamic>> searchWeather(String lat, String long) async{
    Map<String,dynamic> result = {
      'status':false,
      'data':'',
      'message': '',
    };
    try {
      final uriUrl = Uri.parse("${Constants.OPEN_WEATHER_API_URL}?lat=$lat&lon=$long&exclude=minutely,alerts&appid=${Constants.OPEN_WEATHER_API_KEY}");
      final response = await http.get(uriUrl);
      final decodedResponse = returnResponse(response);
      if(response.statusCode == 200){  
        result['data']    = WeatherInfo.fromJson(decodedResponse);
        result['message'] = 'OK'; 
        result['status']  = true;
      }else{
        result['message'] = 'Ah ocurrido un error...';
      }  
    } catch (e) {
      result['message'] = e.toString();
    }
    return result;
  }
}