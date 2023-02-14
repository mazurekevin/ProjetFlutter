class Movie {
  final String title;
  final String posterPath;
  final String backdropPath;
  final String tagline;
  final String overview;
  final double voteAverage;
  final String releaseDate;
  final int runtime;
  late final List<String> genres;

  Movie({
    required this.title,
    required this.posterPath,
    required this.backdropPath,
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

  factory Movie.fromJson(
    Map<String, dynamic> json,
    List<String> genres,
  ) =>
      Movie(
        title: json['title'],
        posterPath: json['poster_path'],
        backdropPath: json['backdrop_path'],
        tagline: json['tagline'],
        overview: json['overview'],
        voteAverage: json['vote_average'].toDouble(),
        releaseDate: json['release_date'],
        runtime: json['runtime'],
        genres: genres,
      );

  genresToString() {
    String genresString = '';
    for (var element in genres) {
      genresString += '$element, ';
    }
    return genresString.substring(0, genresString.length - 2);
  }
}
