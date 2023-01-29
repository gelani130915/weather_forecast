// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_forecast/src/models/data/place_model.dart';
import 'package:weather_forecast/src/providers/places_provider.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  final PlacesProvider provider;
  PlacesBloc({required this.provider}) : super(PlacesInitial()) {
    on<PlacesEvent>((event, emit) async {
      if (event is SearchPlacesEvent) {
        emit(LoadingPlaces());
        try {
          final result = await provider.searchPlaces(event.search);
          if (result['status']) {
            emit(SuccessPlacesState(result['data']));
          } else {
            emit(ErroPlaces(result['message']));
          }
        } catch (e) {
          emit(ErroPlaces(e.toString()));
        }
      }
    });
  }
}
