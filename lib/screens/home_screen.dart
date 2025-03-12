import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pilem/models/movie.dart';
import 'package:pilem/screens/detail_screen.dart';
import 'package:pilem/services/api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiServices _apiService = ApiServices();
  List<Movie> _allMovie = [];
  List<Movie> _trendingMovies = [];
  List<Movie> _popularMovies = [];

  Future<void> _loadMovie() async {
    final List<Map<String, dynamic>> allMoviesData =
        await _apiService.getAllMovies();
    final List<Map<String, dynamic>> TrendingMoviesData =
        await _apiService.getTrendingMovies();
    final List<Map<String, dynamic>> popularMoviesData =
        await _apiService.getPopularMovies();

    setState(() {
      _allMovie = allMoviesData.map((e) => Movie.fromJson(e)).toList();
      _trendingMovies =
          TrendingMoviesData.map((e) => Movie.fromJson(e)).toList();
      _popularMovies = popularMoviesData.map((e) => Movie.fromJson(e)).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilem"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          _buildMoviesList("All Movies", _allMovie),
          _buildMoviesList("Trending Movies", _trendingMovies),
          _buildMoviesList("Popular Movies", _popularMovies)
        ],
      )),
    );
  }

  @override
  Widget _buildMoviesList(String title, List<Movie> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                final Movie movie = movies[index];
                return GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(movie: movie))),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        CachedNetworkImage(

                          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          movie.title.length > 14
                              ? '${movie.title.substring(0, 10)}...'
                              : movie.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}