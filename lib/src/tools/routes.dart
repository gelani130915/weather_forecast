import 'package:flutter/material.dart';
import 'package:weather_forecast/src/tools/routes_names.dart';

import 'package:weather_forecast/src/views/home/home_view.dart';
import 'package:weather_forecast/src/views/weather_info/weather_info_view.dart';

Map<String,WidgetBuilder> getApplicationRoutes(){
  return <String,WidgetBuilder>{
    //PAGINAS PRINCIPALES
    homeRoute: (BuildContext context) => const HomeView(),
    weatherInfoRoute: (BuildContext context) => const WeatherInfoView(),
  };
}