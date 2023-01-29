import 'package:weather_forecast/src/models/data/place_model.dart';
import 'package:weather_forecast/src/tools/constants.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/src/tools/custom_app_exception.dart';

class PlacesProvider{

  Future<Map<String,dynamic>> searchPlaces(String search) async{
    Map<String,dynamic> result = {
      'status':false,
      'data':'',
      'message': '',
    };
    try {
      final uriUrl = Uri.parse("${Constants.PLACES_API_URL}?q=$search");
      final response = await http.get(uriUrl);
      final decodedResponse = returnResponse(response);
      if(response.statusCode == 201){ 
        List<Place> places = []; 
        decodedResponse.forEach((item){
          places.add(Place.fromJson(item));
        }); 
        result['data']    = places;
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