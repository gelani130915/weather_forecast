part of 'places_bloc.dart';

@immutable
abstract class PlacesState {}

class PlacesInitial extends PlacesState {}

class LoadingPlaces extends PlacesState{}

class ErroPlaces extends PlacesState{
  final String error; 
  ErroPlaces(this.error);
  List<Object> get props => [error];
}

class SuccessPlacesState extends PlacesState{
  final List<Place> places;
  SuccessPlacesState(this.places);
  List<Object> get props => [places];
}