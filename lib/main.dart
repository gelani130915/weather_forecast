import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/src/blocs/places_bloc/places_bloc.dart';
import 'package:weather_forecast/src/blocs/weather_bloc/weather_bloc.dart';
import 'package:weather_forecast/src/providers/places_provider.dart';
import 'package:weather_forecast/src/providers/weather_provider.dart';

import 'package:weather_forecast/src/tools/routes.dart';
import 'package:weather_forecast/src/tools/routes_names.dart';
import 'package:weather_forecast/src/tools/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = UserPreferences();
  await prefs.initPrefs();

  runApp(MultiBlocProvider(
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
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: const Color(0xff002674),
              ),
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
                actionsIconTheme: Theme.of(context)
                    .iconTheme
                    .copyWith(color: const Color(0xffce348b)),
              )),
      debugShowCheckedModeBanner: false,
      routes: getApplicationRoutes(),
      initialRoute: homeRoute,
    );
  }
}
