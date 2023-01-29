part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class LoadingWeather extends WeatherState{}

class ErroWeather extends WeatherState{
  final String error; 
  ErroWeather(this.error);
  List<Object> get props => [error];
}
