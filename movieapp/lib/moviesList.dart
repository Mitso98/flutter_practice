import 'package:flutter/material.dart';
import 'package:movieapp/models/api_adress.dart';
import 'package:movieapp/models/movie.dart';

class MoviesList extends StatelessWidget {
  final List? movieList;

  final String title;
  final int currentMovieListIndex;
  const MoviesList({
    super.key,
    required this.movieList,
    required this.title,
    required this.currentMovieListIndex,
  });

  @override
  Widget build(BuildContext context) {
    const movieImageUrl = 'https://image.tmdb.org/t/p/original/';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.only(left: 10, top: 15),
            child: Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 22))),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/MovieDetails',
                    arguments: movieList is List<Movie>
                        ? movieList![index]
                        : movieList![currentMovieListIndex][index],
                  );
                },
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    child: Column(children: [
                      AspectRatio(
                        aspectRatio: 4 / 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                          ),
                          child: Image.network(
                            movieImageUrl +
                                (movieList is List<Movie>
                                    ? movieList![index].posterPath
                                    : movieList![currentMovieListIndex][index]
                                        .posterPath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          movieList is List<Movie>
                              ? movieList![index].title
                              : movieList![currentMovieListIndex][index].title,
                          softWrap: true,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
