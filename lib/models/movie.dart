import 'package:flutter/foundation.dart';

class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String relaseData;
  final double voteAverage;

  Movie({required this.id, required this.title, required this.overview, required this.posterPath, required this.backdropPath, required this.relaseData, required this.voteAverage});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      relaseData: json['relase_data'],
      
      voteAverage: json['vote_average'].toDouble(),
    );
  }
}