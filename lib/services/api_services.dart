import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class ApiServices {
  static const String apiKey = 'f14ecb9f9e5568d15b54e02845a9ec5b';
  static const String baseUrl = 'https://api.themoviedb.org';

  Future<List<Map<String, dynamic>>> getAllMovies() async {
    final response = await http.get(
      Uri.parse("$baseUrl/movie/now_playing?api_keys=$apiKey"),
    );
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }

  Future<List<Map<String, dynamic>>> getTrendingMovies() async {
    final response = await http.get(
      Uri.parse("$baseUrl/trending//movie/week?api_keys=$apiKey"),
    );
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }
  
  Future<List<Map<String, dynamic>>> getPopularMovies() async {
    final response = await http.get(
      Uri.parse("$baseUrl/movie/popular?api_keys=$apiKey"),
    );
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }
}