import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/src/blocs/weather_bloc/weather_bloc.dart';
import 'package:weather_forecast/src/tools/constants.dart';
import 'package:weather_forecast/src/tools/routes_names.dart';
import 'package:weather_forecast/src/widgets/search_places_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text(Constants.APP_NAME),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              scaffoldKey.currentState!.showBottomSheet(
                (context){
                return  SearchPlacesWidget(
                  onSelected: (place)=>Navigator.of(context).pushNamed(weatherInfoRoute, arguments: place),
                );
              });
            }
          , icon: Icon(Icons.place))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            children: [
            ],
          ),
        ),
      ),
    );
  }
}
