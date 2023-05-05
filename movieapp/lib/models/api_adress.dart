enum Url {
  popular,
  topRated,
}

String getUrl(Url url) {
  switch (url) {
    case Url.popular:
      return 'https://api.themoviedb.org/3/movie/popular?api_key=1d4917c940b184e002b3d307b69f89dc';
    case Url.topRated:
      return 'https://api.themoviedb.org/3/movie/top_rated?api_key=1d4917c940b184e002b3d307b69f89dc';
    default:
      return 'unknown';
  }
}

String getString(Url value) {
  switch (value) {
    case Url.popular:
      return 'Popular';
    case Url.topRated:
      return 'Top Rated';
    default:
      return 'unknown';
  }
}

int getIndex(Url value) {
  switch (value) {
    case Url.popular:
      return 0;
    case Url.topRated:
      return 1;
    default:
      return 1000;
  }
}
