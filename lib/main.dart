import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/src/blocs/places_bloc/places_bloc.dart';
import 'package:weather_forecast/src/blocs/weather_bloc/weather_bloc.dart';
import 'package:weather_forecast/src/providers/places_provider.dart';
import 'package:weather_forecast/src/providers/weather_provider.dart';

import 'package:weather_forecast/src/tools/routes.dart';
import 'package:weather_forecast/src/tools/routes_names.dart';

void main() {
  runApp( MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => PlacesBloc(provider: PlacesProvider()),
      ),
      BlocProvider(
        create: (context) => WeatherBloc(provider: WeatherProvider()),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forecast',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      routes: getApplicationRoutes(),
      initialRoute: homeRoute,
    );
  }
}
