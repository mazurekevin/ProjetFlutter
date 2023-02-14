class Movie {
  final String title;
  final String posterPath;
  final String tagline;
  final String overview;
  final double voteAverage;
  final String releaseDate;
  final int runtime;
  late final List<String> genres;

  Movie({
    required this.title,
    required this.posterPath,
    required this.tagline,
    required this.overview,
    required this.voteAverage,
    required this.releaseDate,
    required this.runtime,
    required this.genres,
  });

  static getGenres(dynamic element) {
    List<String> genres = [];
    element.forEach((element) {
      genres.add(element['name']);
    });
    return genres;
  }

  static createMovie(dynamic json) {
    List<String> genres = getGenres(json['genres']);
    Movie movie = Movie.fromJson(json, genres);
    return movie;
  }

  factory Movie.fromJson(Map<String, dynamic> json, List<String> genres) {
    if (json['title'] == "") {
      json['title'] = '';
    }
    if (json['poster_path'] == "") {
      json['poster_path'] = '';
    }
    if (json['tagline'] == "") {
      json['tagline'] = '';
    }
    if (json['overview'] == "") {
      json['overview'] = '';
    }
    if (json['vote_average'] == "") {
      json['vote_average'] = 0;
    }
    if (json['release_date'] == "") {
      json['release_date'] = '';
    }
    if (json['runtime'] == "") {
      json['runtime'] = 0;
    }
    if (json['genres'] == "") {
      json['genres'] = [];
    }

    return Movie(
      title: json['title'],
      posterPath: json['poster_path'],
      tagline: json['tagline'],
      overview: json['overview'],
      voteAverage: json['vote_average'].toDouble(),
      releaseDate: json['release_date'],
      runtime: json['runtime'],
      genres: genres,
    );
  }

  genresToString() {
    String genresString = '';
    for (var element in genres) {
      genresString += '$element, ';
    }
    return genresString.substring(0, genresString.length - 2);
  }
}
