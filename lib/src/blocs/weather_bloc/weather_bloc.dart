// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_forecast/src/models/data/weather_model.dart';
import 'package:weather_forecast/src/providers/weather_provider.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherProvider provider;
  WeatherBloc({required this.provider}) : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit)async{
      if(event is SearchWeatherEvent){
        emit(LoadingWeather());
        try {
          final result = await provider.searchWeather(event.lat, event.long);
          if (result['status']) {
            emit(SuccessGetWeatherState(result['data']));
          } else {
            emit(ErroWeather(result['message']));
          }
        } catch (e) {
          emit(ErroWeather(e.toString()));
        }
      }
    });
  }
}
