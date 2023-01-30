// To parse this JSON data, do
//
//     final place = placeFromJson(jsonString);

import 'dart:convert';

Place placeFromJson(String str) => Place.fromJson(json.decode(str));

String placeToJson(Place data) => json.encode(data.toJson());

class Place {
  Place({
    this.id,
    this.slug,
    this.citySlug,
    this.display,
    this.asciiDisplay,
    this.cityName,
    this.cityAsciiName,
    this.state,
    this.country,
    this.lat,
    this.long,
    this.resultType,
    this.popularity,
    this.sortCriteria,
  });

  int? id;
  String? slug;
  String? citySlug;
  String? display;
  String? asciiDisplay;
  String? cityName;
  String? cityAsciiName;
  String? state;
  String? country;
  String? lat;
  String? long;
  String? resultType;
  String? popularity;
  double? sortCriteria;

  Place copyWith({
    int? id,
    String? slug,
    String? citySlug,
    String? display,
    String? asciiDisplay,
    String? cityName,
    String? cityAsciiName,
    String? state,
    String? country,
    String? lat,
    String? long,
    String? resultType,
    String? popularity,
    double? sortCriteria,
  }) =>
      Place(
        id: id ?? this.id,
        slug: slug ?? this.slug,
        citySlug: citySlug ?? this.citySlug,
        display: display ?? this.display,
        asciiDisplay: asciiDisplay ?? this.asciiDisplay,
        cityName: cityName ?? this.cityName,
        cityAsciiName: cityAsciiName ?? this.cityAsciiName,
        state: state ?? this.state,
        country: country ?? this.country,
        lat: lat ?? this.lat,
        long: long ?? this.long,
        resultType: resultType ?? this.resultType,
        popularity: popularity ?? this.popularity,
        sortCriteria: sortCriteria ?? this.sortCriteria,
      );

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        id: json["id"],
        slug: json["slug"],
        citySlug: json["city_slug"],
        display: json["display"],
        asciiDisplay: json["ascii_display"],
        cityName: json["city_name"],
        cityAsciiName: json["city_ascii_name"],
        state: json["state"],
        country: json["country"],
        lat: json["lat"],
        long: json["long"],
        resultType: json["result_type"],
        popularity: json["popularity"],
        sortCriteria: json["sort_criteria"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "city_slug": citySlug,
        "display": display,
        "ascii_display": asciiDisplay,
        "city_name": cityName,
        "city_ascii_name": cityAsciiName,
        "state": state,
        "country": country,
        "lat": lat,
        "long": long,
        "result_type": resultType,
        "popularity": popularity,
        "sort_criteria": sortCriteria,
      };
}
