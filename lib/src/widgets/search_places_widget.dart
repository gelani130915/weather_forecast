import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/src/blocs/places_bloc/places_bloc.dart';
import 'package:weather_forecast/src/models/data/place_model.dart';

class SearchPlacesWidget extends StatefulWidget {
  final Function(Place) onSelected;
  const SearchPlacesWidget({Key? key, required this.onSelected})
      : super(key: key);

  @override
  State<SearchPlacesWidget> createState() => _SearchPlacesWidgetState();
}

class _SearchPlacesWidgetState extends State<SearchPlacesWidget> {
  final TextEditingController _searchCont = TextEditingController();
  List<Place> _places = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlacesBloc, PlacesState>(
      listener: (context, state) {
        if (state is SuccessPlacesState) {
          setState(() {
            _places = state.places;
          });
        }
      },
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextFormField(
              controller: _searchCont,
              onChanged: (value) => _getPlacesData(context, value),
              autofocus: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  prefixIcon: const Icon(Icons.search)),
            ),
          ),
          ...List.generate(
              _places.length,
              (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListTile(
                      title: Text(_places[index].display!),
                      subtitle: Text(_places[index].state!),
                      onTap: () {
                        Navigator.of(context).pop();
                        widget.onSelected(_places[index]);
                      },
                    ),
                  ))
        ],
      ),
    );
  }

  //Métodos para agregar estados al bloc
  void _getPlacesData(BuildContext context, String search) {
    setState(() {
      _places = [];
    });
    BlocProvider.of<PlacesBloc>(context).add(SearchPlacesEvent(search));
  }
}
