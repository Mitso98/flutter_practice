import 'package:flutter/material.dart';
import 'package:movieapp/models/movie.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ModalRoute.of(context)?.settings.arguments as Movie?;
    const movieImageUrl = 'https://image.tmdb.org/t/p/original/';

    return Scaffold(
        appBar: AppBar(
          title: const Text("Details"),
        ),
        body: LayoutBuilder(builder: (BuildContext ctx, constraints) {
          return Column(children: [
            SizedBox(
                width: double.infinity,
                height: constraints.maxHeight -
                    MediaQuery.of(context).padding.top -
                    50,
                child: Image.network(movieImageUrl + movie!.posterPath)),
            Text(movie.title),
          ]);
        }));
  }
}
