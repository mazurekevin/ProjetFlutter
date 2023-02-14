import 'dart:convert';

MoviePreview moviePreviewFromJson(String str) => MoviePreview.fromJson(json.decode(str));
String moviePreviewToJson(MoviePreview data) => json.encode(data.toJson());

class MoviePreview {
  int id;
  String title;
  String posterPath;
  double voteAverage;
  String releaseDate;

  MoviePreview({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
    required this.releaseDate,
  });

  static List<MoviePreview> listMoviePreview(dynamic json) {
    List<MoviePreview> listMoviePreview = [];
    var i = 0;
    print(json);
    json.forEach((element) {
      MoviePreview moviePreview = MoviePreview.fromJson(element);
      print(i);
      print(moviePreview);
      print('!!!!!!!!!!!!!');
      i++;
      listMoviePreview.add(moviePreview);
    });
    return listMoviePreview;
  }

  factory MoviePreview.fromJson(Map<String, dynamic> json) {
    if (json["poster_path"] == null) {
      json["poster_path"] = "";
    }

    return MoviePreview(
      id: json["id"],
      title: json["title"],
      posterPath: json["poster_path"],
      voteAverage: json["vote_average"].toDouble(),
      releaseDate: json["release_date"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "poster_path": posterPath,
    "vote_average": voteAverage,
    "release_date": releaseDate,
  };
}
