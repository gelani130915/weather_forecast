part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class SearchWeatherEvent extends WeatherEvent{
  final String lat;
  final String long;
  SearchWeatherEvent(this.lat, this.long);
  List<Object> get props => [lat, long];
}