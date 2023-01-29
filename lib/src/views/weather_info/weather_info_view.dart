import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/src/blocs/weather_bloc/weather_bloc.dart';
import 'package:weather_forecast/src/models/data/place_model.dart';

class WeatherInfoView extends StatefulWidget {
  const WeatherInfoView({Key? key}) : super(key: key);

  @override
  State<WeatherInfoView> createState() => _WeatherInfoViewState();
}

class _WeatherInfoViewState extends State<WeatherInfoView> {
  Place? place;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      place = ModalRoute.of(context)!.settings.arguments as Place;
      _getPlacesData(context, place?.lat ?? "", place?.long ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
          ],
        ),
      ),
    );
  }

  void _getPlacesData(BuildContext context, String lat, String long) {
    BlocProvider.of<WeatherBloc>(context).add(SearchWeatherEvent(lat, long));
  }
}
