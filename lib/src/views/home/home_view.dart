import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_forecast/src/models/data/place_model.dart';
import 'package:weather_forecast/src/tools/constants.dart';
import 'package:weather_forecast/src/tools/paths.dart';
import 'package:weather_forecast/src/tools/routes_names.dart';
import 'package:weather_forecast/src/tools/user_preferences.dart';
import 'package:weather_forecast/src/widgets/search_places_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final UserPreferences _userPreferences = UserPreferences();
  List<Place> _favs = [];
  @override
  void initState() {
    for (Map<String, dynamic> item
        in (json.decode(_userPreferences.favorites) as List<dynamic>)) {
      _favs.add(Place.fromJson(item));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text(Constants.APP_NAME),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  scaffoldKey.currentState!.showBottomSheet((context) {
                    return SearchPlacesWidget(
                      onSelected: (place) async {
                        await Navigator.of(context)
                            .pushNamed(weatherInfoRoute, arguments: place);
                        setState(() {
                          _favs.clear();
                          for (Map<String, dynamic> item
                              in (json.decode(_userPreferences.favorites)
                                  as List<dynamic>)) {
                            _favs.add(Place.fromJson(item));
                          }
                        });
                      },
                    );
                  });
                },
                child: IgnorePointer(
                  ignoring: true,
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 15),
                        prefixIcon: const Icon(Icons.search)),
                  ),
                ),
              ),
              _favs.isEmpty
                  ? Column(
                      children: [
                        const SizedBox(height: 50),
                        Center(
                          child: SvgPicture.asset(
                            Paths.locationImage,
                            height: 250,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Center(
                          child: Text(
                            'You don\'t have any favorites yet, try searching for a place.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    )
                  : Column(
                      children: [
                        const SizedBox(height: 20),
                        ...List.generate(
                            _favs.length,
                            (i) => Card(
                                  child: ListTile(
                                    title: Text(_favs[i].display!),
                                    subtitle: Text(_favs[i].state!),
                                    leading: const Icon(Icons.favorite),
                                    trailing: IconButton(
                                      icon: const Icon(
                                          Icons.delete_forever_outlined),
                                      onPressed: () {
                                        final List<Place> auxList = [];
                                        for (Place item in _favs) {
                                          if (item.id != _favs[i].id!) {
                                            auxList.add(item);
                                          }
                                        }
                                        _userPreferences.favorites =
                                            json.encode(auxList);
                                        setState(() {
                                          _favs = auxList;
                                        });
                                      },
                                    ),
                                    onTap: () async {
                                      await Navigator.of(context).pushNamed(
                                          weatherInfoRoute,
                                          arguments: _favs[i]);
                                      setState(() {
                                        _favs.clear();
                                        for (Map<String, dynamic> item
                                            in (json.decode(
                                                    _userPreferences.favorites)
                                                as List<dynamic>)) {
                                          _favs.add(Place.fromJson(item));
                                        }
                                      });
                                    },
                                  ),
                                ))
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
