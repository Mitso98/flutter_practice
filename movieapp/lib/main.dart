import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movieapp/models/api_adress.dart';
import 'package:movieapp/movie_details.dart';
import 'package:movieapp/moviesList.dart';
import 'models/movie.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const colorScheme = ColorScheme.light(
      primary: Colors.white,
      primaryContainer: Colors.orange,
      secondary: Colors.grey,
      background: Colors.white,
      surface: Colors.white,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onBackground: Colors.black,
      onError: Colors.white,
      onSurface: Colors.black,
    );
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: colorScheme,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      title: 'Fetch Movies Demo',
      home: MoviesPage(),
      routes: {
        '/MovieDetails': (context) => MovieDetails(),
      },
    );
  }
}

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  List<List<Movie>>? _movie;

  int id = 550;
  Future fetchMovie(List<String> urls) async {
    List<List<Movie>> movieList = [];
    List<Movie> tempList = [];
    List responseList = [];

    for (final url in urls) {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
      responseList.add(response);
    }

    for (var response in responseList) {
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = await jsonDecode(response.body);

        for (final obj in json["results"]) {
          tempList.add(Movie.fromJson(obj));
        }
        movieList.add(tempList);
        tempList = [];
      } else {
        throw Exception('Failed to fetch movie');
      }
    }
    return movieList;
  }

  @override
  void initState() {
    super.initState();
    fetchMovie([getUrl(Url.popular), getUrl(Url.topRated)]).then((movie) {
      setState(() {
        _movie = movie;
      });
    }).catchError((e) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: _movie == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  MoviesList(
                    title: "All Movies",
                    movieList: _movie!.expand((row) => row).toList(),
                    currentMovieListIndex: 0,
                  ),
                  MoviesList(
                    title: getString(Url.topRated),
                    movieList: _movie,
                    currentMovieListIndex: getIndex(Url.topRated),
                  ),
                  MoviesList(
                    title: getString(Url.popular),
                    movieList: _movie,
                    currentMovieListIndex: getIndex(Url.popular),
                  ),
                ],
              ),
            ),
    );
  }
}
