import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/src/blocs/places_bloc/places_bloc.dart';
import 'package:weather_forecast/src/models/data/place_model.dart';
import 'package:weather_forecast/src/models/interface/selectable_item.dart';
import 'package:weather_forecast/src/tools/constants.dart';
import 'package:weather_forecast/src/widgets/search_places_widget.dart';
import 'package:weather_forecast/src/widgets/search_widget.dart';

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
                  onSelected: (place){
                    print(place);
                  },
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
              // SearchWidget<Place>(
              //   label: 'Text', 
              //   initialList: _places,
              //   controller: _searchCont,
              //   onSearch: (search)=>_getPlacesData(context, search),
              //   getSelectedValue: (SelectableItem? item){

              //   }), 
            ],
          ),
        ),
      ),
    );
  }


}
