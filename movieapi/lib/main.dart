import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'movie.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Fetch Movies Demo',
      home: MoviesPage(),
    );
  }
}

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  Movie? _movie;
  int id = 550;
  Future<Movie> fetchMovie(int id) async {
    final response = await http
        .get(Uri.parse(
            'https://api.themoviedb.org/3/movie/$id?api_key=1d4917c940b184e002b3d307b69f89dc'))
        .timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      print(Movie.fromJson(json));
      return Movie.fromJson(json);
    } else {
      throw Exception('Failed to fetch movie');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMovie(id).then((movie) {
      setState(() {
        _movie = movie;
      });
    }).catchError((e) {
      print(e);
    });
  }

  void _next() {
    setState(() {
      id += 1;
      fetchMovie(id).then((movie) {
        setState(() {
          _movie = movie;
        });
      }).catchError((e) {
        print(e);
      });
    });
  }

  void _prev() {
    setState(() {
      id -= 1;
      fetchMovie(id).then((movie) {
        setState(() {
          _movie = movie;
        });
      }).catchError((e) {
        print(e);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Movies Demo'),
      ),
      body: Center(
        child: _movie == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _movie!.title,
                    style: const TextStyle(
                        fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Image.network(
                      'https://image.tmdb.org/t/p/original/${_movie!.posterPath}',
                      scale: 8),
                  const SizedBox(height: 10.0),
                  Text(
                    _movie!.overview,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: _next, child: const Text("Next")),
                      const SizedBox(width: 200.0),
                      ElevatedButton(
                          onPressed: _prev, child: const Text("Previous")),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
