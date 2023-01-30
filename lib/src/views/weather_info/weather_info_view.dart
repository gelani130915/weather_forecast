import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_forecast/src/blocs/weather_bloc/weather_bloc.dart';
import 'package:weather_forecast/src/models/data/place_model.dart';
import 'package:weather_forecast/src/models/data/weather_model.dart';
import 'package:weather_forecast/src/tools/paths.dart';
import 'package:weather_forecast/src/tools/tools_functions.dart';

class WeatherInfoView extends StatefulWidget {
  const WeatherInfoView({Key? key}) : super(key: key);

  @override
  State<WeatherInfoView> createState() => _WeatherInfoViewState();
}

class _WeatherInfoViewState extends State<WeatherInfoView> {
  Place? place;
  WeatherInfo? info;
  bool _favorite = false;
  bool _showLoader = true;
  bool _shorError = false;
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
      body: BlocListener<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is SuccessGetWeatherState) {
            setState(() {
              info = state.weatherInfo;
            });
          } else if (state is ErroWeather) {
            setState(() {
              _shorError = true;
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
            ));
          }

          if (state is LoadingWeather) {
            setState(() {
              _showLoader = true;
            });
          } else {
            setState(() {
              _showLoader = false;
            });
          }
        },
        child: Stack(
          children: [ 
            CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  snap: false,
                  pinned: true,
                  floating: false,
                  flexibleSpace: const FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("Weather",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                  ),
                  expandedHeight: 150,
                  actions: <Widget>[
                    IconButton(
                        icon: Icon(_favorite
                            ? Icons.favorite
                            : Icons.favorite_outline),
                        color: !_favorite
                            ? Theme.of(context).colorScheme.background
                            : null,
                        tooltip: 'Add to favorites',
                        onPressed: () => setState(() {
                              _favorite = !_favorite;
                            })),
                  ],
                ),
                if(!_showLoader)
                SliverList(
                  delegate: SliverChildListDelegate(
                    _shorError
                    ? [
                      const SizedBox(height: 100),
                      Center(
                        child: SvgPicture.asset(
                          Paths.errorImage,
                          height: 250,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          'Ups... Something has gone wrong',
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                      )
                    ]
                    : [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 15, right: 15),
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        shadowColor: Theme.of(context).colorScheme.primary,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                place?.display ?? "--",
                                style: const TextStyle(fontSize: 22),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                toolFunction.getCustomFormattedDateTime(
                                    info?.current?.dt ?? 00,
                                    'E, d MMM yyyy hh:mm a'),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${info?.current?.temp?.toString() ?? ""}°",
                                    style: const TextStyle(fontSize: 40),
                                  ),
                                ],
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: _getHousrWeather(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        shadowColor: Theme.of(context).colorScheme.primary,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _getDaysWeather(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 100)
                  ]),
                )
              ],
            ),
            if (_showLoader)
              Center(
                child: SizedBox(
                  width: 150,
                  height: 250,
                  child: LottieBuilder.asset(
                    Paths.loader,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  List<Widget> _getHousrWeather() {
    List<Widget> result = [];
    for (Current element in (info?.hourly ?? [])) {
      if (DateTime.fromMillisecondsSinceEpoch(element.dt! * 1000).day ==
          DateTime.now().day) {
        result.add(Card(
          color: Colors.blue[100],
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(toolFunction.getCustomFormattedDateTime(
                    element.dt!, 'hh a')),
                const SizedBox(height: 15),
                Text(
                  "${element.temp!.toStringAsFixed(2)}°",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Icon(
                      Icons.water_drop_outlined,
                      size: 13,
                    ),
                    Text(
                      "${element.pop!} %",
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
      }
    }
    return result;
  }

  List<Widget> _getDaysWeather() {
    List<Widget> result = [];
    result.add(Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Expanded(child: Text(' ')),
          Expanded(child: Text('Min.', textAlign: TextAlign.center)),
          Expanded(child: Text('Max.', textAlign: TextAlign.end)),
        ],
      ),
    ));
    for (Daily element in (info?.daily ?? [])) {
      if (toolFunction.unixToDateTime(element.dt!).isAfter(DateTime.now()) &&
          toolFunction
              .unixToDateTime(element.dt!)
              .isBefore(toolFunction.addDays(element.dt!, 7))) {
        result.add(Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(
                toolFunction.getCustomFormattedDateTime(element.dt!, 'EEEE'),
                style: const TextStyle(fontWeight: FontWeight.bold),
              )),
              Expanded(
                  child: Text(
                "${element.temp!.min!.toStringAsFixed(2)}°",
                textAlign: TextAlign.center,
              )),
              Expanded(
                  child: Text("${element.temp!.max!.toStringAsFixed(2)}°",
                      textAlign: TextAlign.end)),
            ],
          ),
        ));
      }
    }
    return result;
  }

  void _getPlacesData(BuildContext context, String lat, String long) {
    BlocProvider.of<WeatherBloc>(context).add(SearchWeatherEvent(lat, long));
  }
}
