part of 'places_bloc.dart';

@immutable
abstract class PlacesEvent {}

class SearchPlacesEvent extends PlacesEvent{
  final String search;
  SearchPlacesEvent(this.search);
  List<Object> get props => [search];
}