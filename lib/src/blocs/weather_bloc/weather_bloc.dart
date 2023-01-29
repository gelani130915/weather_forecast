import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_forecast/src/providers/weather_provider.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherProvider provider;
  WeatherBloc({required this.provider}) : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
